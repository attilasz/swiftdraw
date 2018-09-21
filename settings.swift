#!/usr/bin/env swift

import AppKit

let width: CGFloat = 128
let height: CGFloat = 128

let path = CommandLine.arguments[0] as NSString
let output = (path.deletingPathExtension as NSString).appendingPathExtension("pdf")!
var box = CGRect(x: 0.0, y: 0.0, width: width, height: height)
guard let context = CGContext(NSURL(fileURLWithPath: output, isDirectory: false), mediaBox: &box, nil) else {exit(EXIT_FAILURE)}

context.beginPDFPage(nil)
context.setFillColor(NSColor(white: 0.0, alpha: 1.0).cgColor)
context.setStrokeColor(NSColor(white: 0.0, alpha: 1.0).cgColor)
context.setLineWidth(6)
context.setLineJoin(.round)
context.setLineCap(.round)
// uncomment for flipped
context.scaleBy(x: 1, y: -1)
context.translateBy(x: 0, y: -height)
// START DRAWING
for _ in 1...8 {
	//context.addArc(center: CGPoint(x: 0, y: 50), radius: 14, startAngle: .pi + 0.5, endAngle: -0.5, clockwise: false)
	context.saveGState()
	context.translateBy(x: box.midX, y: box.midY)
	context.addArc(center: CGPoint(x: 0, y: -50), radius: 14, startAngle: 0.5, endAngle: .pi - 0.5, clockwise: false)
	context.addLine(to: CGPoint(x: 24, y: -36))
print(context.currentPointOfPath)
//	context.closePath()
//	context.strokePath()
	context.restoreGState()
	context.rotate(by: .pi * 2 / 7)
}
print(context.currentPointOfPath)
context.strokePath()

//context.move(to: CGPoint(x: box.midX, y: height - 20))
//context.addCurve(to: CGPoint(x: box.midX, y: 30), control1: CGPoint(x: 0, y: 60), control2: CGPoint(x: 20, y: 0))
//let currPath = context.path
//context.scaleBy(x: -1, y: 1)
//context.translateBy(x: -width, y: 0)
//context.addPath(currPath!)
context.strokePath()
// END

context.endPDFPage()
