//
//  TriangleCell.swift
//  RightAngleCalculator
//
//  Created by admin on 10/27/17.
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
        
        let width = (self.contentView.frame.size.width)/3.0
        let height = self.contentView.frame.size.height
        
        self.aLabel = UILabel.init(frame: CGRect(x: 10, y: -5, width: width, height: height))
        self.bLabel = UILabel.init(frame: CGRect(x: 35+1*width, y: -5, width: width, height: height))
        self.cLabel = UILabel.init(frame: CGRect(x: 50+2*width, y: -5, width: width, height: height))
        
        self.aLabel.font = UIFont.italicSystemFont(ofSize: 20)
        self.bLabel.font = UIFont.italicSystemFont(ofSize: 20)
        self.cLabel.font = UIFont.italicSystemFont(ofSize: 20)
        
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
        
        divider1 = UIView.init(frame: CGRect(x: 30+width, y: 1, width: 0.5, height: height/2+9))
        divider1.backgroundColor = UIColor.gray
        
        divider2 = UIView.init(frame: CGRect(x: 45+2*width, y: 1, width: 0.5, height: height/2+9))
        divider2.backgroundColor = UIColor.gray
        
        self.contentView.addSubview(divider1)
        self.contentView.addSubview(divider2)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


