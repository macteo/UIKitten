//
//  CLLocation.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 22/08/16.
//  Copyright © 2016 Dolomate. All rights reserved.
//

import CoreLocation
import MapKit
import Foundation

public class Location: NSObject, StringConvertible, Coordinated {
    public let timestamp: Date
    public let coordinate: CLLocationCoordinate2D
    public let altitude: CLLocationDistance
    public let horizontalAccuracy: CLLocationAccuracy
    public let verticalAccuracy: CLLocationAccuracy
    public let course: CLLocationDirection
    public let speed: CLLocationSpeed

    public init(location: CLLocation) {
        self.coordinate = location.coordinate
        self.altitude = location.altitude
        self.timestamp = location.timestamp
        self.horizontalAccuracy = location.horizontalAccuracy
        self.verticalAccuracy = location.verticalAccuracy
        self.course = location.course
        self.speed = location.speed
    }

    public init(coordinate: CLLocationCoordinate2D, altitude: CLLocationDistance = 0, horizontalAccuracy: CLLocationAccuracy = -1, verticalAccuracy: CLLocationAccuracy = -1, course: CLLocationDirection = -1, speed : CLLocationSpeed = -1, timestamp : Date = Date()) {
        self.coordinate = coordinate
        self.altitude = altitude
        self.horizontalAccuracy = horizontalAccuracy
        self.verticalAccuracy = verticalAccuracy
        self.timestamp = timestamp
        self.course = course
        self.speed = speed
    }
    
    required public init?(string: String) {
        let components = string.components(separatedBy: "|")
        guard components.count == 8 else { return nil }
        
        guard let interval = Double(components[0]) else { return nil }
        
        self.timestamp = Date(timeIntervalSince1970: interval)
        
        guard let latitude = Double(components[1]) else { return nil }
        guard let longitude = Double(components[2]) else { return nil }
        
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        guard let altitude = Double(components[3]) else { return nil }
        self.altitude = altitude
        
        guard let horizontalAccuracy = Double(components[4]) else { return nil }
        self.horizontalAccuracy = horizontalAccuracy
        
        guard let verticalAccuracy = Double(components[5]) else { return nil }
        self.verticalAccuracy = verticalAccuracy
        
        if let course = CLLocationDirection(components[6]) {
            self.course = course
        } else {
            self.course = -1.0
        }
        
        if let speed = CLLocationSpeed(components[7]) {
            self.speed = speed
        } else {
            self.speed = -1.0
        }
    }
    
    public var string: String {
        return "\(timestamp.timeIntervalSince1970)|\(coordinate.latitude.format(d: 6))|\(coordinate.longitude.format(d: 6))|\(Int(altitude))|\(Int(horizontalAccuracy))|\(Int(verticalAccuracy))|\(Int(course))|\(Int(speed))"
    }

    public var location: CLLocation {
        let l = CLLocation(coordinate: coordinate, altitude: altitude, horizontalAccuracy: horizontalAccuracy, verticalAccuracy: verticalAccuracy, timestamp: timestamp)
        return l
    }

    public func distance(from: Location) -> CLLocationDistance {
        return location.distance(from: from.location)
    }

    public func distance(fromCL: CLLocation) -> CLLocationDistance {
        return location.distance(from: fromCL)
    }
    
    #if os(iOS)
    public var mapItem : MKMapItem {
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        return mapItem
    }
    #endif
    
    public var json: [String: Any] {
        let dictionary: [String: Any] = ["lat": coordinate.latitude, "lon": coordinate.longitude, "altitude": altitude, "horizontalAccuracy": horizontalAccuracy, "verticalAccuracy": verticalAccuracy]
        return dictionary
    }
}
