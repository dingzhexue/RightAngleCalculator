//
//  TriangleCell.swift
//  RightAngleCalculator
//
//  Created by 123 on 10/27/17.
//  Copyright © 2017 ShenYang. All rights reserved.
//

import UIKit

class TriangleCell : UITableViewCell{
    @IBOutlet var aLabel: UILabel!
    @IBOutlet var bLabel: UILabel!
    @IBOutlet var cLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    init(style:UITableViewCellStyle, reuseIdentifier:String){
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let width = (self.contentView.frame.size.width - 10)/3.0
        let height = self.contentView.frame.size.height
        
        self.aLabel = UILabel.init(frame: CGRect(x: 5, y: -3, width: width-4, height: height))
        self.bLabel = UILabel.init(frame: CGRect(x: 5+1*width, y: -3, width: width-4, height: height))
        self.cLabel = UILabel.init(frame: CGRect(x: 5+2*width, y: -3, width: width-4, height: height))

        self.aLabel.font = UIFont.italicSystemFont(ofSize: 16)
        self.bLabel.font = UIFont.italicSystemFont(ofSize: 16)
        self.cLabel.font = UIFont.italicSystemFont(ofSize: 16)

        self.aLabel.minimumScaleFactor = 0.2
        self.bLabel.minimumScaleFactor = 0.2
        self.cLabel.minimumScaleFactor = 0.2

        self.aLabel.adjustsFontSizeToFitWidth = true
        self.bLabel.adjustsFontSizeToFitWidth = true
        self.cLabel.adjustsFontSizeToFitWidth = true
        
        self.contentView.addSubview(self.aLabel)
        self.contentView.addSubview(self.bLabel)
        self.contentView.addSubview(self.cLabel)

        var divider1:UIView!
        var divider2:UIView!
        
        divider1 = UIView.init(frame: CGRect(x: 5+width-4, y: 2, width: 0.5, height: height - 4))
        divider1.backgroundColor = UIColor.gray

        divider2 = UIView.init(frame: CGRect(x: 5+2*width-4, y: 2, width: 0.5, height: height - 4))
        divider2.backgroundColor = UIColor.gray
        
        self.contentView.addSubview(divider1)
        self.contentView.addSubview(divider2)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


