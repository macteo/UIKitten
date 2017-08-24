//: [Previous](@previous)

//: **PFP Categories Chart**

//#-hidden-code
import UIKit
import PlaygroundSupport

//#-end-hidden-code

let controller = UIViewController()
controller.view.backgroundColor = .white

//#-hidden-code
controller.view.frame = CGRect(x: 0, y: 0, width: 375, height: 375)
//#-end-hidden-code

//#-editable-code

func image(string: String, size: CGSize, attributes: [String: Any]?) -> UIImage? {
    
    UIGraphicsBeginImageContext(size)
    (string as NSString).draw(in: CGRect(x: 0, y:0, width: size.width, height: size.height), withAttributes: attributes)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    return image
}

let blue = UIColor(red: 100/255, green: 158/255, blue: 205/255, alpha: 1)
let green = UIColor(red: 82/255, green: 189/255, blue: 113/255, alpha: 1)
let yellow = UIColor(red: 240/255, green: 185/255, blue: 0, alpha: 1)
let purple = UIColor(red: 140/255, green: 80/255, blue: 160/255, alpha: 1)
let gray = UIColor(red: 147/255, green: 147/255, blue: 148/255, alpha: 1)


let darkGray = UIColor(red: 75/255, green: 75/255, blue: 77/255, alpha: 1)
let amaranto = UIColor(red: 202/255, green: 69/255, blue: 63/255, alpha: 1)

let pie = PieChart(frame: CGRect(x: 0, y: 0, width: 375, height: 270))
pie.setExtraOffsets(left: 10, top: 16, right: 10, bottom: 33)

pie.clipsToBounds = false
pie.rotationEnabled = true

let attributes = [
    NSFontAttributeName            : UIFont.systemFont(ofSize: 10),
    NSForegroundColorAttributeName : gray,
    NSBackgroundColorAttributeName : UIColor.clear
]

let altreSpeseImage = image(string: "Altre spese", size: CGSize(width: 80, height: 22), attributes: attributes)


let dataSet = PieChartDataSet(values: [
    PieChartDataEntry(value: 17, icon: UIImage(named: "categoria.png")),
    PieChartDataEntry(value: 11, icon: UIImage(named: "categoria.png")),
    PieChartDataEntry(value: 11, icon: UIImage(named: "categoria.png")),
    PieChartDataEntry(value: 11, icon: UIImage(named: "categoria.png")),
    PieChartDataEntry(value: 39, icon: altreSpeseImage)
    ], label: nil)
dataSet.drawIconsEnabled = true
dataSet.iconsOffset = CGPoint(x: 0, y: 30)
dataSet.colors = [blue, green, yellow, purple, gray]
dataSet.sliceSpace = 0
dataSet.selectionShift = 0
dataSet.automaticallyDisableSliceSpacing = true

let centerParagraphStyle = NSMutableParagraphStyle()
centerParagraphStyle.alignment = .center
centerParagraphStyle.lineSpacing = 2

let speseTotaliAttributes = [
    NSFontAttributeName            : UIFont.systemFont(ofSize: 13),
    NSParagraphStyleAttributeName  : centerParagraphStyle,
    NSForegroundColorAttributeName : darkGray,
    NSBackgroundColorAttributeName : UIColor.clear
]

let totalAttributes = [
    NSFontAttributeName            : UIFont.systemFont(ofSize: 20, weight: UIFontWeightSemibold),
    NSParagraphStyleAttributeName  : centerParagraphStyle,
    NSForegroundColorAttributeName : amaranto,
    NSBackgroundColorAttributeName : UIColor.clear
]

let speseTotali = NSAttributedString(string: "Spese totali", attributes: speseTotaliAttributes)
let total = NSAttributedString(string: "-2.400,00", attributes: totalAttributes)

let centerString = NSMutableAttributedString()
centerString.append(speseTotali)
centerString.append(NSAttributedString(string: "\n"))
centerString.append(total)

pie.centerAttributedText = centerString

let data = PieChartData(dataSet: dataSet)
data.setValueTextColor(.clear)
dataSet.drawIconsEnabled = true

pie.data = data

pie.holeRadiusPercent = 0.8
pie.backgroundColor = .clear
pie.alpha = 1


controller.view.addSubview(pie)
let templateImage = UIImage(named: "grafico torta.png")
let templateImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 375, height: 270))
templateImageView.image = templateImage
templateImageView.alpha = 0.0
controller.view.addSubview(templateImageView)
// controller.view.sendSubview(toBack: templateImageView)

//#-end-editable-code

//#-hidden-code
PlaygroundPage.current.liveView = controller
