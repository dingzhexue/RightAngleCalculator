//
//  Triangle.swift
//  RightAngleCalculator
//
//  Created by admin on 10/27/17.
//

import Foundation

class Triangle: NSObject {
    
    var legA : Double = 0.0
    var legB : Double = 0.0
    var hypotenuse : Double = 0.0
    
    func triangleFromString(string: String) -> Triangle {
        let triangle = Triangle.init()
        var array = string.components(separatedBy: "-")
        
        triangle.legA = Double(array[0])!
        triangle.legB = Double(array[1])!
        triangle.hypotenuse = Double(array[2])!
        
        return triangle;
    }
    
    func stringFromTriangle(triangle:Triangle) ->String{
        let triangleString = String(format:"%f-%f-%f",triangle.legA,triangle.legB,triangle.hypotenuse)
        
        return triangleString
    }
}


