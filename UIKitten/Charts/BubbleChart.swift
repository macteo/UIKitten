//
//  BubbleChart.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 28/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

#if COCOAPODS
    import Charts
#endif


public class BubbleChart : BubbleChartView, Alignable {

    // MARK: Alignable protocol
    
    public var width: Width? = .container(ratio: 1)
    public var height: Height? = .width(ratio: 0.5)
    public var margin = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    public var align : Align? = [.top, .left]
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: View Lifecycle
    
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
        
        dataSet(values: [BubbleChartDataEntry(x: 0, y: 1, size: 1), BubbleChartDataEntry(x: 1, y: 0, size: 2), BubbleChartDataEntry(x: 3, y: 2, size: 3)], colors: [.success, .warning, .info])
        zoomOut()
    }
    
    
    public func dataSet(values: [BubbleChartDataEntry], label: String? = nil, colors: [UIColor]? = nil, alpha: CGFloat = 1) {
        let dataSet = BubbleChartDataSet(values: values, label: label)
        dataSet.visible = true
        dataSet.drawValuesEnabled = false
        
        if let colors = colors {
            dataSet.setColors(colors, alpha: alpha)
        }
        
        let data = BubbleChartData(dataSet: dataSet)
        data.setValueTextColor(.clear)
        self.data = data
    }
}
