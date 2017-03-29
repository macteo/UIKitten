//#-hidden-code
import UIKit
//#-end-hidden-code

//: **Overview**: how do you draw a Bézier curve?
//#-hidden-code
import UIKit
import PlaygroundSupport

//#-end-hidden-code

let table = TableController()

//#-editable-code

let button = Button(title: "Hello World")
button.padding = 10
button.type = .success
button.align = [.right]

table.items = [[button]]

//#-end-editable-code

//#-hidden-code
let navController = UINavigationController(rootViewController: table)
let window = UIWindow()
window.rootViewController = navController

table.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)

window.makeKeyAndVisible()

window.autoresizingMask = [.flexibleHeight,.flexibleWidth]

PlaygroundPage.current.liveView = window

//#-end-hidden-code
//: [Next](@next)