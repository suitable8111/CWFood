//
//  MainMenuViewController.swift
//  CWFood
//
//  Created by 김대호 on 2015. 7. 17..
//  Copyright (c) 2015년 김대호. All rights reserved.


import UIKit


class MainMenuViewController : UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var blackBtn: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var topicScrollView: UIScrollView!
    @IBOutlet weak var scrollPageControl: UIPageControl!
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var topicNameLabel: UILabel!
    @IBOutlet weak var topicNameLabel2: UILabel!
    @IBOutlet weak var topicNameLabel3: UILabel!
    @IBOutlet weak var topicNameLabel4: UILabel!
    @IBOutlet weak var topicNameLabel5: UILabel!
    
    @IBOutlet weak var topicImage1: UIButton!
    @IBOutlet weak var topicImage2: UIButton!
    @IBOutlet weak var topicImage3: UIButton!
    @IBOutlet weak var topicImage4: UIButton!
    @IBOutlet weak var topicImage5: UIButton!
    
    
    var profileDic : NSMutableDictionary!
    
    var dataAry : NSArray!
    var topicAry : NSArray!
    
    override func viewWillAppear(animated: Bool) {
        self.automaticallyAdjustsScrollViewInsets = false
        
        let path = getFileName("BabyProfile.plist")
        let fileManager = NSFileManager.defaultManager()
        
        if(!fileManager.fileExistsAtPath(path)){
            let orgPath = NSBundle.mainBundle().pathForResource("BabyProfile", ofType: "plist")
            do {
                try fileManager.copyItemAtPath(orgPath!, toPath: path)
            } catch _ {
            }
        }
        
        
        profileDic = NSMutableDictionary(contentsOfFile: path)
        
        
        
        //profileImageView.image = UIImage(data:profileDic.valueForKey("image") as! NSData)
        if(profileDic.count != 0){
            profileImageView.image = UIImage(data: profileDic.valueForKey("image") as! NSData)
        }
        
        profileNameLabel.text = profileDic.valueForKey("name") as? String
        profileImageView.layer.cornerRadius = 40
        profileImageView.layer.masksToBounds = true

        
        self.blackBtn.alpha = 0
        
        let url = NSBundle.mainBundle().URLForResource("MidFoodList", withExtension: "plist")
        dataAry = NSArray(contentsOfURL: url!)
        
        let topicUrl = NSBundle.mainBundle().URLForResource("TopicFoodList", withExtension: "plist")
        topicAry = NSArray(contentsOfURL: topicUrl!)
        
        self.mainScrollView.contentOffset.x = 0
        topicScrollView.delegate = self
        topicScrollView.contentSize = CGSizeMake(1875, 500)
        mainScrollView.contentSize = CGSizeMake(610, 667)
        
        topicNameLabel.text = topicAry.objectAtIndex(0).valueForKey("title") as? String
        topicNameLabel2.text = topicAry.objectAtIndex(1).valueForKey("title") as? String
        topicNameLabel3.text = topicAry.objectAtIndex(2).valueForKey("title") as? String
        topicNameLabel4.text = topicAry.objectAtIndex(3).valueForKey("title") as? String
        topicNameLabel5.text = topicAry.objectAtIndex(4).valueForKey("title") as? String
        
        topicImage1.setImage(UIImage(named: (topicAry.objectAtIndex(0).valueForKey("image") as? String)!), forState: UIControlState.Normal)
        topicImage2.setImage(UIImage(named: (topicAry.objectAtIndex(1).valueForKey("image") as? String)!), forState: UIControlState.Normal)
        topicImage3.setImage(UIImage(named: (topicAry.objectAtIndex(2).valueForKey("image") as? String)!), forState: UIControlState.Normal)
        topicImage4.setImage(UIImage(named: (topicAry.objectAtIndex(3).valueForKey("image") as? String)!), forState: UIControlState.Normal)
        topicImage5.setImage(UIImage(named: (topicAry.objectAtIndex(4).valueForKey("image") as? String)!), forState: UIControlState.Normal)
        
        
    }
    @IBAction func actOpenProfile(sender: AnyObject) {
        UIView.animateWithDuration(0.5, animations: {
            self.mainScrollView.contentOffset.x = 235
            //self.profileView.transform = CGAffineTransformMakeTranslation(-235, 0);
            self.blackBtn.alpha = 0.5
        })
        
    }
    @IBAction func actPrevious(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func actBackMenu(sender: AnyObject) {
        UIView.animateWithDuration(0.5, animations: {
            self.mainScrollView.contentOffset.x = 0
            //self.profileView.transform = CGAffineTransformMakeTranslation(0, 0);
            self.blackBtn.alpha = 0
        })

    }
    func getFileName(fileName:String) -> String {
        let docsDir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let docPath = docsDir[0] 
        let fullName = docPath.stringByAppendingString(fileName)
        return fullName
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let indexPage = scrollView.contentOffset.x / scrollView.frame.width
        scrollPageControl.currentPage = Int(indexPage)
    }
    
    @IBAction func actTopic1(sender: AnyObject) {
        let dlControl = self.storyboard?.instantiateViewControllerWithIdentifier("DetailListViewController") as! DetailListViewController
        dlControl.dic = topicAry[sender.tag] as! NSDictionary
        self.navigationController?.pushViewController(dlControl,animated: true)
    }
    
}
