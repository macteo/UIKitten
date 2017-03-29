//
//  ChartsViewController.swift
//  UIKitten Catalog
//
//  Created by Matteo Gavagnin on 28/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKitten

class ChartsViewController: TableController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barView = BarChart(frame: CGRect(x: 0, y: 0, width: 260, height: 120))
        let bubbleView = BubbleChart(frame: CGRect(x: 0, y: 0, width: 260, height: 120))
        let lineView = LineChart(frame: CGRect(x: 0, y: 0, width: 260, height: 120))
        let pieView = PieChart(frame: CGRect(x: 0, y: 0, width: 260, height: 120))
        let scatterView = ScatterChart(frame: CGRect(x: 0, y: 0, width: 260, height: 120))
        let radarView = RadarChart(frame: CGRect(x: 0, y: 0, width: 260, height: 120))
        
        items = [
            [bubbleView, barView, lineView, pieView, scatterView, radarView]
        ]
    }
}