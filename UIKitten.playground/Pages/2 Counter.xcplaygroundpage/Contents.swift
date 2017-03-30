//: [Previous](@previous)

//: **Counter**

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

let counter = Counter(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
counter.value = 946
counter.caption = "Sales"

controller.view.addSubview(counter)

//#-end-editable-code

//#-hidden-code
PlaygroundPage.current.liveView = controller

//#-end-hidden-code
//: [Next](@next)
