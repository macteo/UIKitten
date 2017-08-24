//
//  BarChart.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 26/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

#if COCOAPODS
    import Charts
#endif

public class BarChart : BarChartView, Alignable {
    
    // MARK: Alignable protocol
    
    public var width: Width? = .container(ratio: 1)
    public var height: Height? = .width(ratio: 0.5)
    public var margin = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    public var align : Align? = [.top, .left]
    public var vertical : Vertical?
    public var horizontal : Horizontal?
    
    // MARK: View Lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        setViewPortOffsets(left: 0, top: 0, right: 0, bottom: 0)
        backgroundColor = .clear
        fitBars = false
        xAxis.enabled = false
        leftAxis.enabled = false
        rightAxis.enabled = false
        pinchZoomEnabled = false
        doubleTapToZoomEnabled = false
        dragEnabled = false
        legend.enabled = false
        chartDescription?.enabled = false
        
        dataSet(values: [BarChartDataEntry(x: 0, y: 1), BarChartDataEntry(x: 1, y: 0.2), BarChartDataEntry(x: 2, y: 1.2), BarChartDataEntry(x: 3, y: 2)], colors: [.success, .warning, .info, .danger])
    }
    
    public func dataSet(values: [BarChartDataEntry], label: String? = nil, colors: [UIColor]? = nil, alpha: CGFloat = 1) {
        let dataSet = BarChartDataSet(values: values, label: label)
        if let colors = colors {
            dataSet.setColors(colors, alpha: alpha)
        }
        
        let data = BarChartData(dataSet: dataSet)
        data.barWidth = 1.0
        data.setValueTextColor(.clear)
        self.data = data
    }
}
