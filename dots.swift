#!/usr/bin/env swift
// attilasz@attilaszabo.org

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
context.setLineWidth(8)
context.setLineJoin(.round)
context.setLineCap(.round)
// uncomment for flipped
context.scaleBy(x: 1, y: -1)
context.translateBy(x: 0, y: -height)

// START DRAWING
for i in 1...3 {
	context.addArc(center: CGPoint(x: box.maxX / 4 * CGFloat(i), y: box.midY), radius: 10, startAngle: 0, endAngle: .pi * 2, clockwise: true)
	context.fillPath()
}
// END

context.endPDFPage()
