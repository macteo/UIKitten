//#-hidden-code
import UIKit
//#-end-hidden-code

//: [Previous](@previous)
//: **Pie**
//#-hidden-code
import UIKit
import PlaygroundSupport

//#-end-hidden-code

let controller = UIViewController()
controller.view.backgroundColor = .white

//#-hidden-code
controller.view.frame = CGRect(x: 0, y: 0, width: 320, height: 320)
//#-end-hidden-code

//#-editable-code

let pie = PieChart(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
pie.dataSet(values: [PieChartDataEntry(value: 10), PieChartDataEntry(value: 20), PieChartDataEntry(value: 30, icon: UIImage.fontAwesomeIcon(name: .cartPlus, textColor: .white, size: CGSize(width: 30, height: 30)))], colors: [.warning, .danger, .success])
controller.view.addSubview(pie)

//#-end-editable-code

//#-hidden-code
PlaygroundPage.current.liveView = controller
