//
//  TriangleView.swift
//  RightAngleCalculator
//
//  Created by admin on 10/27/17.
//
import UIKit

class TriangleView: UIView {
    
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
        
        context.setStrokeColor(red:0.0, green:0.0, blue:0.0, alpha:1.0)
        
        context.setLineWidth(1.0)
        
        context.setFillColor(red: 76/255, green: 142/255, blue: 226/255, alpha: 1.0)
        
        context.beginPath()

        context.move(to: CGPoint(x: 0, y: self.frame.size.height))
        context.addLine(to:CGPoint(x: self.frame.size.width, y:self.frame.size.height))
        context.addLine(to: CGPoint(x:0, y:0))
        context.closePath()

        context.fillPath()

        context.beginPath()
        context.move(to: CGPoint(x:1,y:self.frame.size.height-1))
        context.addLine(to:CGPoint(x: self.frame.size.width-1, y:self.frame.size.height-1))
        context.addLine(to: CGPoint(x:1, y:1))
        context.closePath()

        context.strokePath()
    }
    
    
    
}
