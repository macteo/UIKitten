//
//  BarChart.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 26/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import Charts

public class BarChart : BarChartView, Alignable {
    // Alignable protocol
    public var padding : Int = 0
    public var align : Align = [.top, .left]
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
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
        
        let dataSet = BarChartDataSet(values: [BarChartDataEntry(x: 0, y: 1), BarChartDataEntry(x: 1, y: 0.1), BarChartDataEntry(x: 2, y: 1.2), BarChartDataEntry(x: 3, y: 2)], label: "")
        // dataSet.setColors(ChartColorTemplates.material)
        
        let data = BarChartData(dataSet: dataSet)
        data.barWidth = 0.9
        data.setValueTextColor(.clear)
        
        self.data = data
    }
    
    // TODO: Use some kind of proportion to return the data information
    public override var intrinsicContentSize: CGSize {
        let _ = super.intrinsicContentSize
        
        return CGSize(width: bounds.size.width, height: bounds.size.width / 2)
    }

}
