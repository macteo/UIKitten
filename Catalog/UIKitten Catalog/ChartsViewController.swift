//
//  ChartsViewController.swift
//  UIKitten Catalog
//
//  Created by Matteo Gavagnin on 28/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKitten
import Charts
import FontAwesome_swift

class ChartsViewController: TableController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
        
        let barView = BarChart(frame: CGRect(x: 0, y: 0, width: 260, height: 120))
        let bubbleView = BubbleChart(frame: CGRect(x: 0, y: 0, width: 260, height: 120))
        let lineView = LineChart(frame: CGRect(x: 0, y: 0, width: 260, height: 120))
        let pieView = PieChart(frame: CGRect(x: 0, y: 0, width: 260, height: 120))
        
        let cart = UIImage.fontAwesomeIcon(name: .shoppingCart, textColor: .white, size: CGSize(width: 30, height: 30))
        let money = UIImage.fontAwesomeIcon(name: .money, textColor: .white, size: CGSize(width: 30, height: 30))
        let car = UIImage.fontAwesomeIcon(name: .car, textColor: .white, size: CGSize(width: 30, height: 30))
        
        pieView.dataSet(values: [PieChartDataEntry(value: 30, icon: cart), PieChartDataEntry(value: 40, icon: money), PieChartDataEntry(value: 30, icon: car), PieChartDataEntry(value: 10)], colors: [.success, .warning, .info, .danger], alpha: 0.8)
        
        let scatterView = ScatterChart(frame: CGRect(x: 0, y: 0, width: 260, height: 120))
        let radarView = RadarChart(frame: CGRect(x: 0, y: 0, width: 260, height: 120))
        
        items = [
            [pieView, bubbleView, barView, lineView, scatterView, radarView]
        ]
    }
}
