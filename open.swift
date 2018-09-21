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
context.setLineWidth(12)
context.setLineJoin(.round)
context.setLineCap(.round)
// uncomment for flipped
context.scaleBy(x: 1, y: -1)
context.translateBy(x: 0, y: -height)

// START DRAWING
context.move(to: CGPoint(x: 30, y: box.midY))
context.addLine(to: CGPoint(x: box.maxX - 30, y: box.midY))
context.addLine(to: CGPoint(x: box.maxX - 55, y: 35))
context.strokePath()
context.move(to: CGPoint(x: box.maxX - 30, y: box.midY))
context.addLine(to: CGPoint(x: box.maxX - 55, y: box.maxY - 35))
context.strokePath()
// END

context.endPDFPage()
