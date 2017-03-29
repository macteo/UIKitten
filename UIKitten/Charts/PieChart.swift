//
//  PieChart.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 29/03/2017.
//  Copyright © 2017 Dolomate. All rights reserved.
//

#if COCOAPODS
    import Charts
#endif


public class PieChart : PieChartView, Alignable {
    
    // MARK: Alignable protocol
    
    public var width: Width? = .container(ratio: 1)
    public var height: Height? = .width(ratio: 0.5)
    public var padding : Int = 0
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
        
        let dataSet = PieChartDataSet(values: [PieChartDataEntry(value: 1), PieChartDataEntry(value: 0.2), PieChartDataEntry(value: 1.2), PieChartDataEntry(value: 2)], label: "")
        let data = PieChartData(dataSet: dataSet)
        data.setValueTextColor(.clear)
        
        self.data = data
    }
}

