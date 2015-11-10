//
//  BoardDetailViewController.swift
//  CWFood
//
//  Created by 김대호 on 2015. 8. 11..
//  Copyright (c) 2015년 김대호. All rights reserved.
//

import UIKit

class BoardDetailViewController : UIViewController{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
 
    @IBOutlet weak var descLabel: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var guestImage: UIImageView!
    @IBOutlet weak var guestImage2: UIImageView!
    @IBOutlet weak var guestImage3: UIImageView!
    @IBOutlet weak var nameImage: UIImageView!
    var dataDic : NSDictionary = [:]
    
    override func viewWillAppear(animated: Bool) {
        timeLabel.text = dataDic.valueForKey("time") as? String
//        titleLabel.text = dataDic.valueForKey("title") as? String
//        descLabel.text = dataDic.valueForKey("Desc") as? String
        nameLabel.text = dataDic.valueForKey("name") as? String
        descLabel.allowsEditingTextAttributes = true
//       descLabel.attributedText = NSAttributedString(string: "이번 일주일은 어떻게 지나갔는지 모르겠어요 하루 종일 이유식을 먹어도 애가 헛구역질을 하고 토를 하더라고요 그래서 여기 게시물에 한번 올려봅니다 혹시 신생아도 아닌데 자주 토하는 경우가 있나요? 우리 애가 그래요.... 6개월이 넘어가는데 모유를 먹어도 그렇고 분유를 먹어도 그렇고... 별 차도가 없네요 소화를 못 시키는 것 같아요... 뭘 먹여야 할까요?")

        //descLabel.typingAttributes = ["Spacing" : 3]
        guestImage.layer.cornerRadius = 24
        guestImage.layer.masksToBounds = true
        guestImage2.layer.cornerRadius = 24
        guestImage2.layer.masksToBounds = true
        guestImage3.layer.cornerRadius = 24
        guestImage3.layer.masksToBounds = true
        nameImage.layer.cornerRadius = 24
        nameImage.layer.masksToBounds = true
        
        contentScrollView.contentSize = CGSizeMake(375, 1100);
    }
    
    @IBAction func actPrevious(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
}