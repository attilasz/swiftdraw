#!/usr/bin/env swift

import AppKit

let width = 128
let height = 128

let path = CommandLine.arguments[0] as NSString
let output = (path.deletingPathExtension as NSString).appendingPathExtension("pdf")!
var box = CGRect(x: 0, y: 0, width: width, height: height)
guard let context = CGContext(NSURL(fileURLWithPath: output, isDirectory: false), mediaBox: &box, nil) else {exit(EXIT_FAILURE)}

context.beginPDFPage(nil)
context.setFillColor(NSColor(white: 0.0, alpha: 1.0).cgColor)
context.setStrokeColor(NSColor(white: 0.0, alpha: 1.0).cgColor)
context.setLineWidth(10)
context.setLineJoin(.round)
context.setLineCap(.round)
// uncomment for flipped
context.scaleBy(x: 1, y: -1)
context.translateBy(x: 0, y: -CGFloat(height))

// START DRAWING
context.translateBy(x: box.midX, y: box.midY)
context.rotate(by: .pi / 4)
for _ in 1...2 {
	context.move(to: CGPoint(x: -56, y: 0))
	context.addLine(to: CGPoint(x: 56, y: 0))
	context.rotate(by: .pi / 2)
}
context.strokePath()
// END
context.endPDFPage()
