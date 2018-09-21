#!/usr/bin/env swift

import AppKit

let width: CGFloat = 128
let height: CGFloat = 128

let path = CommandLine.arguments[0] as NSString
let output = (path.deletingPathExtension as NSString).appendingPathExtension("pdf")!
var box = CGRect(x: 0, y: 0, width: width, height: height)
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
context.addArc(center: CGPoint(x: box.midX, y: box.midY), radius: 40, startAngle: 0, endAngle: .pi * 2, clockwise: true)
let currPath = context.path
context.saveGState()
context.clip()
context.addArc(center: CGPoint(x: box.midX, y: box.midY + 70), radius: 60, startAngle: 0, endAngle: .pi * 2, clockwise: true)
context.fillPath()
context.restoreGState()
context.addPath(currPath!)
context.strokePath()
context.addEllipse(in: CGRect(x: box.midX - 18, y: box.midY - 26, width: 36, height: 44))
context.fillPath()
// END

context.endPDFPage()
