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
context.setLineWidth(4)
context.setLineJoin(.round)
context.setLineCap(.round)
// uncomment for flipped
//context.scaleBy(x: 1, y: -1)
//context.translateBy(x: 0, y: -height)

// START DRAWING

let colors = [NSColor.white.cgColor, NSColor.white.cgColor] as CFArray
let colorSpace = CGColorSpaceCreateDeviceRGB()
let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: nil)
context.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: box.maxY), end: CGPoint(x: box.maxX, y: 0), options: [])
//let str = "\u{1f600}"
let str = "\u{0024}"
let color = NSColor(red: 200 / 255, green: 46 / 255, blue: 80 / 255, alpha: 1.0)
let font = NSFont(name: "Helvetica Neue UltraLight", size: 100)!
let attributes = [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: font]
var size = (str as NSString).size(withAttributes: attributes)
let cap = font.capHeight
let line = CTLineCreateWithAttributedString(NSAttributedString(string: str, attributes: attributes) as CFAttributedString)
context.textPosition = CGPoint(x: (box.maxX - size.width) / 2, y: (box.maxY - cap) / 2 )
CTLineDraw(line, context)
// END

context.endPDFPage()
