//
//  MapViewController.swift
//  UIKitten Catalog
//
//  Created by Matteo Gavagnin on 07/04/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKitten
import CoreLocation

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let map = Map(frame: view.bounds)
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        guard let gpxUrl = Bundle.main.url(forResource: "half-marathon", withExtension: "gpx") else { return }
        GPX.parse(url: gpxUrl) { (gpx) in
            if let gpx = gpx {
                if let locations = gpx.tracks.first?.fixes.map({ $0.location }) {
                    map.locations = locations
                    map.renderRoute()
                }
            }
        }
        view.addSubview(map)
    }
}
