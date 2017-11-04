//
//  TriangleCell.swift
//  carpentersquare
//
//  Created by Administrator on 10/31/17.
//  Copyright © 2017 RedShepard. All rights reserved.
//

import UIKit

class TriangleCell : UITableViewCell{
     var aLabel: UILabel!
     var bLabel: UILabel!
     var cLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    init(style:UITableViewCellStyle, reuseIdentifier:String,viewWidth:CGFloat,viewHeight:CGFloat){
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let width = viewWidth/3.0
        let height = viewHeight
       
        self.aLabel = UILabel.init(frame: CGRect(x: 5, y: -5, width: width - 5, height: height))
        self.bLabel = UILabel.init(frame: CGRect(x: 1*width, y: -5, width: width, height: height))
        self.cLabel = UILabel.init(frame: CGRect(x: 2*width, y: -5, width: width, height: height))
        
        self.aLabel.font = UIFont.italicSystemFont(ofSize: 17)
        self.bLabel.font = UIFont.italicSystemFont(ofSize: 17)
        self.cLabel.font = UIFont.italicSystemFont(ofSize: 17)
        
//        self.aLabel.minimumScaleFactor = 0.2
//        self.bLabel.minimumScaleFactor = 0.2
//        self.cLabel.minimumScaleFactor = 0.2
        self.aLabel.textAlignment = .center
        self.bLabel.textAlignment = .center
        self.cLabel.textAlignment = .center
        self.aLabel.adjustsFontSizeToFitWidth = true
        self.bLabel.adjustsFontSizeToFitWidth = true
        self.cLabel.adjustsFontSizeToFitWidth = true
        
        self.contentView.addSubview(self.aLabel)
        self.contentView.addSubview(self.bLabel)
        self.contentView.addSubview(self.cLabel)
        
        var divider1:UIView!
        var divider2:UIView!
        
        divider1 = UIView.init(frame: CGRect(x: width, y: 1, width: 0.5, height: height/2+9))
        divider1.backgroundColor = UIColor.gray
        
        divider2 = UIView.init(frame: CGRect(x: 2*width, y: 1, width: 0.5, height: height/2+9))
        divider2.backgroundColor = UIColor.gray
        
        self.contentView.addSubview(divider1)
        self.contentView.addSubview(divider2)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

