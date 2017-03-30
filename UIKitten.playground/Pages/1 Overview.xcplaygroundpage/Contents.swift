//: **Overview**: how do you draw a Bézier curve?

//#-hidden-code
import UIKit
import PlaygroundSupport

//#-end-hidden-code

let table = TableController()

//#-hidden-code
table.view.frame = CGRect(x: 0, y: 0, width: 320, height: 320)
//#-end-hidden-code

//#-editable-code

let button = Button(title: "Hello World")
button.padding = 10
button.type = .success
button.align = [.right]

let danger = Button(title: "Danger")
danger.padding = 0
danger.type = .danger
danger.align = [.right]

let item = Item(title: "Awesome cell", subtitle: "With great subtitle, very long and complex.", view: button, action: { (cell, selected) in
})

table.items = [[item, danger]]

//#-end-editable-code

//#-hidden-code
PlaygroundPage.current.liveView = table

//#-end-hidden-code
//: [Next](@next)
