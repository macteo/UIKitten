//The MIT License (MIT)
//
//Copyright (c) 2016 Dulio Denis
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

import Foundation
import CoreLocation

private var __gpxDateFormatter : DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z"
    return dateFormatter
}()


public class GPX: NSObject, XMLParserDelegate {
    // MARK: - Public API

    public var waypoints = [Waypoint]()
    public var tracks = [Track]()
    public var routes = [Track]()
    
    public typealias GPXCompletionHandler = (GPX?) -> Void
    
    public class func parse(url: URL, completionHandler: @escaping GPXCompletionHandler) {
        GPX(url: url, completionHandler: completionHandler).parse()
    }
    
    // MARK: - Public Classes
    
    public class Track: Entry {
        public var fixes = [Waypoint]()
    }
    
    public class Waypoint: Entry {
        public var latitude: Double
        public var longitude: Double
        public lazy var altitude : Double? = {
            if let ele = self.attributes["ele"] {
                return Double(ele)
            }
            return nil
        }()
        
        public lazy var hr : Int? = {
            if let hrValue = self.attributes["gpxtpx:hr"] {
                return Int(hrValue)
            }
            return nil
            
        }()
        
        public init(latitude: Double, longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
            super.init()
        }
        
        public var info: String? {
            set { attributes["desc"] = newValue }
            get { return attributes["desc"] }
        }
        
        public lazy var date : Date? = {
            if let time = self.attributes["time"] {
                let d = __gpxDateFormatter.date(from: time)
                return d
            }
            return nil
        }()
        
        public lazy var location : Location = {
            let loc = Location(coordinate: CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude))
            return loc
        }()
    }
    
    public class Entry: NSObject {
        public var links = [Link]()
        public var attributes = [String:String]()
        
        public var name: String? {
            set { attributes["name"] = newValue }
            get { return attributes["name"] }
        }
    }
    
    public class Link
    {
        public var href: String
        public var linkAttributes = [String: String]()
        
        public init(href: String) { self.href = href }
        
        public var url: URL? { return URL(string: href) }
        public var text: String? { return linkAttributes["text"] }
        public var type: String? { return linkAttributes["type"] }
    }

    // MARK: - Private Implementation

    private let url: URL
    private let completionHandler: GPXCompletionHandler
    
    private init(url: URL, completionHandler: @escaping GPXCompletionHandler) {
        self.url = url
        self.completionHandler = completionHandler
    }
    
    private func complete(success: Bool) {
        DispatchQueue.main.async {
            self.completionHandler(success ? self : nil)
        }
    }
    
    private func fail() { complete(success: false) }
    private func succeed() { complete(success: true) }
    
    private func parse() {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let data = try Data(contentsOf: self.url)
                let parser = XMLParser(data: data)
                parser.delegate = self
                parser.shouldProcessNamespaces = false
                parser.shouldReportNamespacePrefixes = false
                parser.shouldResolveExternalEntities = false
                parser.parse()
            } catch {
                self.fail()
            }
        }
    }

    public func parserDidEndDocument(_ parser: XMLParser) { succeed() }
    public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) { fail() }
    public func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) { fail() }
    
    private var input = ""

    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        input += string
    }
    
    private var waypoint: Waypoint?
    private var track: Track?
    private var link: Link?

    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        switch elementName {
            case "trkseg":
                if track == nil { fallthrough }
            case "trk":
                tracks.append(Track())
                track = tracks.last
            case "rte":
                routes.append(Track())
                track = routes.last
            case "rtept", "trkpt", "wpt":
                if let latValue = attributeDict["lat"], let latitude = Double(latValue), let lonValue = attributeDict["lon"], let longitude = Double(lonValue){
                    waypoint = Waypoint(latitude: latitude, longitude: longitude)
                }
            case "link":
                if let href = attributeDict["href"]{
                    link = Link(href: href)
                }
            default: break
        }
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName {
            case "wpt":
                if waypoint != nil { waypoints.append(waypoint!); waypoint = nil }
            case "trkpt", "rtept":
                if waypoint != nil { track?.fixes.append(waypoint!); waypoint = nil }
            case "trk", "trkseg", "rte":
                track = nil
            case "link":
                if link != nil {
                    if waypoint != nil {
                        waypoint!.links.append(link!)
                    } else if track != nil {
                        track!.links.append(link!)
                    }
                }
                link = nil
            default:
                if link != nil {
                    link!.linkAttributes[elementName] = input.trimmingCharacters(in: .whitespacesAndNewlines)
                } else if waypoint != nil {
                    waypoint!.attributes[elementName] = input.trimmingCharacters(in: .whitespacesAndNewlines)
                } else if track != nil {
                    track!.attributes[elementName] = input.trimmingCharacters(in: .whitespacesAndNewlines)
                }
                input = ""
        }
    }
}
