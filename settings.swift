#!/usr/bin/env swift

import AppKit

let width: CGFloat = 128
let height: CGFloat = 128

let path = CommandLine.arguments[0] as NSString
let output = (path.deletingPathExtension as NSString).appendingPathExtension("pdf")!
var box = CGRect(x: 0.0, y: 0.0, width: width, height: height)
guard let context = CGContext(NSURL(fileURLWithPath: output, isDirectory: false), mediaBox: &box, nil) else {
	exit(EXIT_FAILURE)
}

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
context.translateBy(x: box.midX, y: box.midY)
for _ in 1...12 {
	context.addArc(center: CGPoint(x: 0, y: -50), radius: 10, startAngle: 0.2, endAngle: .pi - 0.2, clockwise: false)
	context.addLine(to: CGPoint(x: -17.5, y: -46))
	context.strokePath()
	context.rotate(by: .pi * 2 / 11)
}

context.addArc(center: CGPoint(x: 0, y: -0), radius: 14, startAngle: 0.0, endAngle: 2 * .pi , clockwise: false)
context.strokePath()
// END

context.endPDFPage()
