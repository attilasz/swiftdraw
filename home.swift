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
context.setLineWidth(1)
context.setLineJoin(.round)
context.setLineCap(.round)
// uncomment for flipped
context.scaleBy(x: 1, y: -1)
context.translateBy(x: 0, y: -CGFloat(height))

// START DRAWING
context.addRect(CGRect(x: 2, y: 2, width: width - 4, height: height - 4))
context.addRect(CGRect(x: 16, y: 16, width: 40, height: 40))
context.addRect(CGRect(x: 72, y: 16, width: 40, height: 40))
context.addRect(CGRect(x: 16, y: 72, width: 40, height: 40))
context.addRect(CGRect(x: 72, y: 72, width: 40, height: 40))
context.fillPath(using: .evenOdd)
// END

context.endPDFPage()
