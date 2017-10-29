//
//  TriangleLengthsView.swift
//  RightAngleCalculator
//
//  Created by 123 on 10/27/17.
//  Copyright © 2017 ShenYang. All rights reserved.
//

import UIKit

class TriangleLengthsView : UIView{
    
    var size : Float = 0.0
    var padding : Float = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
    }
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    override func draw(_ rect: CGRect) {
        let context:CGContext = UIGraphicsGetCurrentContext()!
        
        context.setStrokeColor(red:0.0, green:0.0, blue:0.0,alpha:1.0)

        context.setLineWidth(2.0)
        
        // a leg
        context.beginPath()
        context.move(to: CGPoint(x: 0.0, y: Double(self.padding + self.size)))
        context.addLine(to: CGPoint(x: Double(self.size), y: Double(self.padding + self.size)))
        context.strokePath()
        
        context.beginPath()
        context.move(to: CGPoint(x: 0.0, y: Double(Float(self.frame.size.height) - self.padding - self.size)))
        context.addLine(to: CGPoint(x: Double(self.size), y: Double(Float(self.frame.size.height) - self.padding - self.size)))
        context.strokePath()
        
        context.beginPath()
        context.move(to: CGPoint(x: Double(self.size/2.0), y: Double(self.padding + self.size)))
        context.addLine(to: CGPoint(x: Double(self.size/2.0), y: Double(Float(self.frame.size.height) - self.padding - self.size)))
        context.strokePath()

        // b leg
        context.beginPath()
        context.move(to: CGPoint(x: Double(self.padding + self.size), y: Double(self.frame.size.height)))
        context.addLine(to: CGPoint(x: Double(self.padding + self.size), y: Double(Float(self.frame.size.height) - self.size)))
        context.strokePath()

        context.beginPath()
        context.move(to: CGPoint(x: Double(Float(self.frame.size.width) - self.padding - self.size), y: Double(self.frame.size.height)))
        context.addLine(to: CGPoint(x: Double(Float(self.frame.size.width) - self.padding - self.size), y: Double(Float(self.frame.size.height) - self.size)))
        context.strokePath()

        context.beginPath()
        context.move(to: CGPoint(x: Double(self.padding + self.size), y: Double(Float(self.frame.size.height) - self.size/2.0)))
        context.addLine(to: CGPoint(x: Double(Float(self.frame.size.width) - self.padding - self.size), y: Double(Float(self.frame.size.height) - self.size/2.0)))
        context.strokePath()

        // c leg
        let angle = atan2f(Float(self.frame.size.width), Float(self.frame.size.height))
        
        context.beginPath()
        context.move(to: CGPoint(
            x: Double(self.padding + self.size + self.padding*cosf(angle)),
            y: Double(self.padding + self.size - self.padding*sinf(angle))
        ))
        context.addLine(to: CGPoint(
            x: Double(self.padding + self.size + (self.size + self.padding)*cosf(angle)),
            y: Double(self.padding + self.size - (self.size + self.padding)*sinf(angle))
        ))
        context.strokePath()
        context.beginPath()
        context.move(to: CGPoint(
            x: Double(Float(self.frame.size.width) - self.padding - self.size + self.padding*cosf(angle)),
            y: Double(Float(self.frame.size.height) - self.padding - self.size - self.padding*sinf(angle))
        ))
        context.addLine(to: CGPoint(
            x: Double(Float(self.frame.size.width) - self.padding - self.size + (self.size + self.padding)*cosf(angle)),
            y: Double(Float(self.frame.size.height) - self.padding - self.size - (self.size + self.padding)*sinf(angle))
        ))
        context.strokePath()
        context.beginPath()
        context.move(to: CGPoint(
            x: Double(self.padding + self.size + (self.size/2.0 + self.padding)*cosf(angle)),
            y: Double(self.padding + self.size - (self.size/2.0 + self.padding)*sinf(angle))
        ))
        context.addLine(to: CGPoint(
            x: Double(Float(self.frame.size.width) - self.padding - self.size + (self.size/2.0 + self.padding)*cosf(angle)),
            y: Double(Float(self.frame.size.height) - self.padding - self.size - (self.size/2.0 + self.padding)*sinf(angle))
        ))
        context.strokePath()

    }
}
