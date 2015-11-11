//
//  ProfileViewController.swift
//  CWFood
//
//  Created by 김대호 on 2015. 7. 10..
//  Copyright (c) 2015년 김대호. All rights reserved.
//

import UIKit

class ProfileViewController : UIViewController {
    var favorDic : NSMutableDictionary!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var aliasLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var kgLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var subNameLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var aboLabel: UILabel!
    
    @IBOutlet weak var babyExplainLabel: UILabel!
    
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var myWriteBtn: UIButton!
    @IBOutlet weak var favorBtn: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        let path = getFileName("BabyProfile.plist")
        
        
        let fileManager = NSFileManager.defaultManager()
        
        if(!fileManager.fileExistsAtPath(path)){
            let orgPath = NSBundle.mainBundle().pathForResource("BabyProfile", ofType: "plist")
            do {
                try fileManager.copyItemAtPath(orgPath!, toPath: path)
            } catch _ {
            }
        }
        favorDic = NSMutableDictionary(contentsOfFile: path)
        
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyMM"
        
        let currentDate = formatter.stringFromDate(date)
        
        let brithString = favorDic.valueForKey("birth") as? String

        if favorDic.count != 0 {
            let yearMonthRange = Range(start:brithString!.startIndex.advancedBy(0), end: brithString!.startIndex.advancedBy(4))
            let monthRange = Range(start:brithString!.startIndex.advancedBy(2), end: brithString!.startIndex.advancedBy(4))
            let dayRange = Range(start:brithString!.startIndex.advancedBy(4), end: brithString!.startIndex.advancedBy(6))
        
            let date1 = formatter.dateFromString(currentDate)
            let date2 = formatter.dateFromString(brithString!.substringWithRange(yearMonthRange))
        
            let cal = NSCalendar(calendarIdentifier: NSGregorianCalendar)
            let c1 = cal?.components(NSCalendarUnit.NSMonthCalendarUnit, fromDate: date2!, toDate: date1!, options: NSCalendarOptions(rawValue: 0))
        
            ageLabel.text = brithString!.substringWithRange(monthRange) + "월" + brithString!.substringWithRange(dayRange) + "일"
            monthLabel.text = String(stringInterpolationSegment: c1!.month) + "개월"
            babyExplainLabel.text = "현재 민빈이는 '중기'입니다^^"
            
            imageView.image = UIImage(data: favorDic.valueForKey("image") as! NSData)

        }
        
        
        nameLabel.text = favorDic.valueForKey("name") as? String
        subNameLabel.text = favorDic.valueForKey("name") as? String
        sexLabel.text = favorDic.valueForKey("sex") as? String
        aliasLabel.text = favorDic.valueForKey("alias") as? String
        heightLabel.text = favorDic.valueForKey("height") as? String
        kgLabel.text = favorDic.valueForKey("kg") as? String
        aboLabel.text = favorDic.valueForKey("abo") as? String
        

        
        imageView.layer.cornerRadius = 37
        imageView.layer.masksToBounds = true
        
        profileBtn.layer.borderWidth = 0.5
        profileBtn.layer.borderColor = UIColor.lightGrayColor().CGColor
        myWriteBtn.layer.borderWidth = 0.5
        myWriteBtn.layer.borderColor = UIColor.lightGrayColor().CGColor
        favorBtn.layer.borderWidth = 0.5
        favorBtn.layer.borderColor = UIColor.lightGrayColor().CGColor
    }
    @IBAction func actPrevious(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    func getFileName(fileName:String) -> String {
        let docsDir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let docPath = docsDir[0] 
        let fullName = docPath.stringByAppendingString(fileName)
        return fullName
    }
}
