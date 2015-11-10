//
//  DetailListViewController.swift
//  CWFood
//
//  Created by 김대호 on 2015. 7. 21..
//  Copyright (c) 2015년 김대호. All rights reserved.
//

import UIKit

class DetailListViewController : UIViewController , UIScrollViewDelegate {
    //var indexPathRow : Int = 0
    var dic : NSDictionary = [:]
    var favorAry : NSMutableArray!
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodTitle: UILabel!
    @IBOutlet weak var tipText: UITextView!
    @IBOutlet weak var howToText: UITextView!
    @IBOutlet weak var cautionText: UITextView!
    @IBOutlet weak var detailScrollView: UIScrollView!
//    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var favorBtn: UIButton!
    override func viewDidLoad() {
        self.automaticallyAdjustsScrollViewInsets = false
        detailScrollView.delegate = self
        let path = getFileName("myFavoriteFood.plist")
        let fileManager = NSFileManager.defaultManager()
        
        if(!fileManager.fileExistsAtPath(path)){
            let orgPath = NSBundle.mainBundle().pathForResource("myFavoriteFood", ofType: "plist")
            do {
                try fileManager.copyItemAtPath(orgPath!, toPath: path)
            } catch _ {
            }
        }
        favorAry = NSMutableArray(contentsOfFile: path)
        foodImage.image = UIImage(named: dic.valueForKey("image") as! String)
        foodTitle.text = dic.valueForKey("title") as? String
        tipText.text = dic.valueForKey("tip") as? String
        howToText.text = dic.valueForKey("howto") as? String
        cautionText.text = dic.valueForKey("needItems") as? String
        detailScrollView.contentSize = CGSizeMake(375, 200)
    }
    @IBAction func actFavor(sender: AnyObject) {
        let path = getFileName("myFavoriteFood.plist")
        let alert = UIAlertView(title: "즐겨찾기", message: "즐겨찾기 메뉴에 추가 되었습니다!", delegate: self, cancelButtonTitle: "확인")
        alert.show()

        favorAry.addObject(dic)
        favorAry.writeToFile(path, atomically: true)
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
