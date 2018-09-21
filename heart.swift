#!/usr/bin/env swift

import AppKit

let width: CGFloat = 128
let height: CGFloat = 128

let filePath = CommandLine.arguments[0] as NSString
let output = (filePath.deletingPathExtension as NSString).appendingPathExtension("pdf")!
var box = CGRect(x: 0.0, y: 0.0, width: width, height: height)
guard let context = CGContext(NSURL(fileURLWithPath: output, isDirectory: false), mediaBox: &box, nil) else {exit(EXIT_FAILURE)}

context.beginPDFPage(nil)
context.setFillColor(NSColor(white: 0.0, alpha: 1.0).cgColor)
context.setStrokeColor(NSColor(white: 0.0, alpha: 1.0).cgColor)
context.setLineWidth(4)
context.setLineJoin(.round)
context.setLineCap(.round)
// uncomment for flipped
context.scaleBy(x: 1, y: -1)
context.translateBy(x: 0, y: -height)

// START DRAWING
var path = CGMutablePath() 
path.move(to: CGPoint(x: box.midX, y: height - 20))
path.addCurve(to: CGPoint(x: box.midX, y: 30), control1: CGPoint(x: 0, y: 60), control2: CGPoint(x: 20, y: 0))
path.move(to: CGPoint(x: box.midX, y: height - 20))
path.addCurve(to: CGPoint(x: box.midX, y: 30), control1: CGPoint(x: 127, y: 60), control2: CGPoint(x: 107, y: 0))
var transform = CGAffineTransform(scaleX: -1, y: 1) 
context.addPath(path)

if CommandLine.arguments.count > 1 {
	context.fillPath()
} else {
	context.strokePath()
}
// END

context.endPDFPage()
