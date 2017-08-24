//
//  Map.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 07/04/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit
import MapKit

public class Map : MKMapView {
    var visitCircles = [MKCircle]()
    var routePolyline: MKPolyline?
    public var locations = [Location]() {
        didSet {
            renderRoute()
        }
    }
    
    override public required init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        delegate = self
        showsScale = false
        showsCompass = false
        showsBuildings = true
        showsUserLocation = true
        showsPointsOfInterest = true
        mapType = .standard
        isPitchEnabled = false
        isRotateEnabled = true
        
        
        // TODO: move to the Label class
        if #available(iOS 10, *) { } else {
            // Only for iOS 9
            NotificationCenter.default.addObserver(self, selector: #selector(self.contentSizeDidChange(notification:)), name: Notification.Name.UIContentSizeCategoryDidChange, object: nil)
        }
    }
    
    func contentSizeDidChange(notification: Notification) {
        traitCollectionDidChange(nil)
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        // TODO: eventually do something
    }
    
    public func renderRoute() {
        if let routePolyline = routePolyline {
            remove(routePolyline)
        }
        let coordinates = locations.map { $0.coordinate }
        let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
        polyline.title = "Route"
        
        add(polyline)
        routePolyline = polyline
    }
    
    func zoomToFitOverlays(overlays: [MKOverlay], animated: Bool, offsetProportion: Double) {
        if overlays.count == 0 {
            return
        }
        
        var mapRect = MKMapRectNull
        if overlays.count == 1 {
            mapRect = overlays.last!.boundingMapRect
        } else {
            for overlay in overlays {
                mapRect = MKMapRectUnion(mapRect, overlay.boundingMapRect)
            }
        }
        
        var proportion = offsetProportion
        if offsetProportion > 1 {
            proportion = 0.9
        }
        
        let offset = mapRect.size.width * proportion
        mapRect = mapRectThatFits(MKMapRectInset(mapRect, -offset, -offset))
        let region = MKCoordinateRegionForMapRect(mapRect)
        if mapRect.size.height > 0 && mapRect.size.width > 0 {
            setRegion(region, animated: true)
        }
    }
    
    func zoomToFit(ne: CLLocationCoordinate2D, sw: CLLocationCoordinate2D) {
        let swPoint = MKMapPointForCoordinate(sw)
        let nePoint = MKMapPointForCoordinate(ne)
        
        let swRect = MKMapRectMake(swPoint.x, swPoint.y, 0, 0)
        let neRect = MKMapRectMake(nePoint.x, nePoint.y, 0, 0)
        
        let mapRect = MKMapRectUnion(swRect, neRect)
        
        setVisibleMapRect(mapRect, animated: false)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


extension Map : MKMapViewDelegate {
    
    public func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        for view in views {
            guard let annotation = view.annotation else { return }
            if annotation.isKind(of: MKUserLocation.self) {
                view.superview?.bringSubview(toFront: view)
            } else {
                view.superview?.sendSubview(toBack: view)
            }
        }
    }
    
    public func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        for annotation in mapView.annotations {
            if annotation.isKind(of: MKUserLocation.self) {
                guard let view = mapView.view(for: annotation) else { return }
                view.superview?.bringSubview(toFront: view)
            }
        }
    }
    
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        // TODO: differentiate between visit locations (home, office)
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "visitHomeAnnotation")
        // TODO: provide an annotation image
        // annotationView.image =
        return annotationView
    }
    
    public func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let circle = MKCircleRenderer(overlay: overlay)
            circle.lineWidth = 1
            if visitCircles.contains(overlay as! MKCircle) {
                circle.strokeColor = UIColor.orange
                circle.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.1)
            } else {
                circle.strokeColor = UIColor.blue
                circle.fillColor = UIColor(red: 0, green: 0, blue: 255, alpha: 0.1)
                circle.lineDashPattern = [8, 8]
            }
            return circle
        } else if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            // renderer.strokeColor = UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1)
            if let title = overlay.title, title == "Route" {
                renderer.strokeColor = UIColor.info.withAlphaComponent(0.8)
                renderer.lineWidth = 4.0
            } else {
                renderer.strokeColor = UIColor.blue.withAlphaComponent(0.5)
                renderer.lineWidth = 6.0
            }
            
            return renderer
        } else {
            return MKCircleRenderer(overlay: overlay)
        }
    }
}
