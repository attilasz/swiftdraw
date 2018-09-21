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
context.addArc(center: CGPoint(x: box.midX, y: box.midY), radius: 60, startAngle: 0, endAngle: .pi * 2, clockwise: true)
let radius = 50.0
let angle: Double = 2 * .pi / 10
let path = CGMutablePath()

for i in 0...10 {
	// 0.36 !
	let _radius = i % 2 == 0 ? radius : radius * 0.44
	let _angle = Double(i) * angle - .pi / 2

	let x = CGFloat(_radius * cos(_angle) + radius)
	let y = CGFloat(_radius * sin(_angle) + radius)

	if i == 0 {
		path.move(to: CGPoint(x: x, y: y))
		continue
	}
	path.addLine(to: CGPoint(x: x, y: y))
}

context.translateBy(x: 14, y: 16)
context.addPath(path)
context.fillPath()
// END

context.endPDFPage()