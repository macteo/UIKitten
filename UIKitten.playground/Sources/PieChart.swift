//
//  PieChart.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 29/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import UIKit

#if COCOAPODS
    import Charts
#endif

public class PieChart : PieChartView, Alignable {
    
    // MARK: Alignable protocol
    
    public var width: Width? = .container(ratio: 1)
    public var height: Height? = .width(ratio: 0.5)
    public var margin = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    public var align : Align? = [.top, .left]
    
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
        backgroundColor = .clear
        legend.enabled = false
        chartDescription?.enabled = false
        
        dataSet(values: [PieChartDataEntry(value: 30), PieChartDataEntry(value: 50), PieChartDataEntry(value: 20), PieChartDataEntry(value: 10)], colors: [.success, .warning, .info, .danger])
    }
    
    public func dataSet(values: [PieChartDataEntry], label: String? = nil, colors: [UIColor]? = nil, alpha: CGFloat = 1) {
        let dataSet = PieChartDataSet(values: values, label: label)
        if let colors = colors {
            dataSet.setColors(colors, alpha: alpha)
        }
        dataSet.sliceSpace = 1
        dataSet.selectionShift = 6
        dataSet.automaticallyDisableSliceSpacing = true
        
        let data = PieChartData(dataSet: dataSet)
        data.setValueTextColor(.clear)
        self.data = data
    }
}

