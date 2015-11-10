//
//  CollectionViewCell.swift
//  CWFood
//
//  Created by 김대호 on 2015. 7. 21..
//  Copyright (c) 2015년 김대호. All rights reserved.
//
import UIKit

class CollectionViewCell: UICollectionViewCell {
    //let button: UIButton!
    let textLabel: UILabel!
    let imageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        //button = UIButton()
        textLabel = UILabel()
        imageView = UIImageView()
        super.init(coder: aDecoder)
    }
    
    
    override init(frame: CGRect) {
        
        //super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        //imageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        
        
        let textFrame = CGRect(x: 0, y: frame.size.height*4/5, width: frame.size.width, height: frame.size.height/5)
        textLabel = UILabel(frame: textFrame)
        textLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        textLabel.textAlignment = .Center
        textLabel.backgroundColor = UIColor.whiteColor()
        textLabel.alpha = 0.8
        textLabel.textColor = UIColor.blackColor()
        //let buttonFrame = CGRect(x: 0, y: 32, width: frame.size.width, height: frame.size.height/3)
        //button = UIButton(frame: buttonFrame)
        
        super.init(frame: frame)
        contentView.addSubview(self.imageView)
        contentView.addSubview(self.textLabel)

    }
}