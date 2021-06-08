#!/usr/bin/env swift

import AppKit

let width: CGFloat = 1024
let height: CGFloat = 1024

let path = CommandLine.arguments[0] as NSString
let output = (path.deletingPathExtension as NSString).appendingPathExtension("pdf")!
var box = CGRect(x: 0.0, y: 0.0, width: width, height: height)
guard let context = CGContext(NSURL(fileURLWithPath: output, isDirectory: false), mediaBox: &box, nil) else {
	exit(EXIT_FAILURE)
}

context.beginPDFPage(nil)
context.setFillColor(NSColor(white: 0.0, alpha: 1.0).cgColor)
context.setStrokeColor(NSColor(white: 1.0, alpha: 1.0).cgColor)
context.setLineWidth(14)
context.setLineJoin(.round)
context.setLineCap(.round)
// uncomment for flipped
context.scaleBy(x: 1, y: -1)
context.translateBy(x: 0, y: -height)

// START DRAWING
let c1 = NSColor(red: 130 / 255, green: 160 / 255, blue: 200 / 255, alpha: 1.0)
let c2 = NSColor(red: 65 / 255, green: 80 / 255, blue: 100 / 255, alpha: 1.0)
let colors = [c1.cgColor, c2.cgColor] as CFArray
let colorSpace = CGColorSpaceCreateDeviceRGB()
let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: nil)
context.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: box.maxY), end: CGPoint(x: box.maxX, y: 0), options: [])
context.translateBy(x: box.midX, y: box.midY)
let teeth = 16
for _ in 1...teeth {
	context.addArc(center: CGPoint(x: 0, y: -(height / 2 - 80)), radius: 56, startAngle: .pi, endAngle: 0, clockwise: true)
	context.rotate(by: .pi * 2 / CGFloat(teeth))
}

context.closePath()
context.strokePath()
context.addArc(center: CGPoint(x: 0, y: -0), radius: height / 8, startAngle: 0.0, endAngle: 2 * .pi , clockwise: false)
context.strokePath()
// END

context.endPDFPage()
