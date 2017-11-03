//
//  Length.swift
//  carpentersquare
//
//  Created by Administrator on 10/31/17.
//  Copyright © 2017 RedShepard. All rights reserved.
//

import Foundation

class Length: NSObject {
    var feet : Int = 0
    var inches : Int = 0
    var sixteenths : Int = 0
    
    func lengthWithFeet(feet: Double) -> Length {
        
        let len = Length.init()
        
        len.feet = Int(floor(feet))
        len.inches = Int(floor(12 * (feet - Double(len.feet))))
        len.sixteenths = Int(round(16*(12*(feet - Double(len.feet)) - Double(len.inches))))
        
        return len;
    }
    
    func formattedStringForFeet(feet: Double) -> String {
        
        let len = lengthWithFeet(feet: feet)
        if(len.feet == 0 && len.sixteenths == 0) {
            return String(format:"%d' %d\"",len.feet,len.inches)
        }
        return String(format:"%d' %d %d/16\"",len.feet,len.inches,len.sixteenths)
    }
    
}
