//
//  BubbleChart.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 28/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import Charts

public class BubbleChart : BubbleChartView, Alignable {

    // Alignable protocol
    public var width: Width? = .container(ratio: 1)
    public var height: Height? = .width(ratio: 0.5)
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
        xAxis.enabled = false
        leftAxis.enabled = false
        rightAxis.enabled = false

        setScaleEnabled(false)
        pinchZoomEnabled = false
        doubleTapToZoomEnabled = false
        dragEnabled = false
        legend.enabled = false
        maxVisibleCount = 100
        chartDescription?.enabled = false
        
        xAxis.spaceMin = 1.5
        xAxis.spaceMax = 1.5
        leftAxis.spaceTop = 1.5
        leftAxis.spaceBottom = 1.5
        
        
        let dataSet = BubbleChartDataSet(values: [BubbleChartDataEntry(x: 0, y: 1, size: 1), BubbleChartDataEntry(x: 1, y: 0, size: 2), BubbleChartDataEntry(x: 3, y: 2, size: 3)], label: "Test")
        dataSet.setColor(UIColor.red.withAlphaComponent(0.5))
        dataSet.visible = true
        dataSet.drawValuesEnabled = false
        
        let data = BubbleChartData(dataSet: dataSet)
        data.setValueTextColor(.black)
        
        self.data = data
        zoomOut()
    }
}
