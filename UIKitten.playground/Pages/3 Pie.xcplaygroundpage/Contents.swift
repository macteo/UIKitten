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
controller.view.addSubview(pie)

//#-end-editable-code

//#-hidden-code
PlaygroundPage.current.liveView = controller
