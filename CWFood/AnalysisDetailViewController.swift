//
//  AnalysisDetailViewController.swift
//  CWFood
//
//  Created by 김대호 on 2015. 7. 28..
//  Copyright (c) 2015년 김대호. All rights reserved.
//

import UIKit
import CoreData

class AnalysisDetailViewController : UIViewController, UITableViewDelegate, UITableViewDataSource ,UITextFieldDelegate {
    static var PRIMEKEY : Int32 = 0
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var tbView: UITableView!
    
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var viewOpenBtn: UIButton!
    
    var appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var contextA : NSManagedObjectContext?
    
    var dataAry : NSMutableArray!
    var count = 0;
    
    var titleText : String = ""
    var imageText : String = ""
    var timeText : String = ""
    
//    var foodEatAry : NSMutableArray!
//    var foodEatDic : NSMutableDictionary!
    var formatter = NSDateFormatter()
    
    override func viewWillAppear(animated: Bool) {
        tbView.dataSource = self
        tbView.delegate = self
        quantityTextField.delegate = self
        nameTextField.delegate = self
        
//        let path = getFileName("BabyEatList.plist")
//        let fileManager = NSFileManager.defaultManager()
//        
//        if(!fileManager.fileExistsAtPath(path)){
//            let orgPath = NSBundle.mainBundle().pathForResource("BabyEatList", ofType: "plist")
//            do {
//                try fileManager.copyItemAtPath(orgPath!, toPath: path)
//            } catch _ {
//            }
//        }
//        foodEatAry = NSMutableArray(contentsOfFile: path)
        
        titleLabel.text = titleText + " 재료"

        menuView.layer.cornerRadius = 5
        menuView.layer.masksToBounds = true
        addBtn.layer.cornerRadius = 5
        addBtn.layer.masksToBounds = true
        cancelBtn.layer.cornerRadius = 5
        cancelBtn.layer.masksToBounds = true
        viewOpenBtn.layer.cornerRadius = 5
        viewOpenBtn.layer.masksToBounds = true
        deleteBtn.layer.cornerRadius = 5
        deleteBtn.layer.masksToBounds = true
        
        contextA = appDel.managedObjectContext
        
        
    }
    @IBAction func AddMenu(sender: AnyObject) {
        UIView.animateWithDuration(1.0, animations: {
            self.menuView.transform = CGAffineTransformMakeTranslation(0, -450);
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataAry.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCellWithIdentifier("AnalysisDetailCell", forIndexPath: indexPath) as UITableViewCell

        
        let text = dataAry.objectAtIndex(indexPath.row).valueForKey("name") as? String
        let quantity = dataAry.objectAtIndex(indexPath.row).valueForKey("quantity") as? String
        let titleLabel = cell.viewWithTag(201) as? UILabel
        titleLabel!.text = text!+quantity!
        
        let favorBtn = UIButton()
        favorBtn.setImage(UIImage(named: "uncheck.png"), forState: UIControlState())
        favorBtn.frame = CGRect(x: 80, y: 25, width: 15, height: 15)
        favorBtn.addTarget(self, action: "addFavor:", forControlEvents: UIControlEvents.TouchUpInside)
        favorBtn.tag = indexPath.row
        cell.contentView.addSubview(favorBtn)
        
        return cell
    }
    func addFavor(sender: UIButton){
        if dataAry.objectAtIndex(sender.tag).valueForKey("delete") as! Bool == true {
            sender.setImage(UIImage(named: "uncheck.png"), forState: UIControlState())
            dataAry.objectAtIndex(sender.tag).setValue(false, forKey: "delete")
        }else {
            sender.setImage(UIImage(named: "checked.png"), forState: UIControlState())
            dataAry.objectAtIndex(sender.tag).setValue(true, forKey: "delete")
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            dataAry.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    @IBAction func DeleteMenu(sender: AnyObject) {
        UIView.animateWithDuration(1.0, animations: {
            self.menuView.transform = CGAffineTransformMakeTranslation(0, 0);
        })
    }
    @IBAction func actDeleteList(sender: AnyObject) {
        for var i = dataAry.count-1; i >= 0; i-- {
            if dataAry.objectAtIndex(i).valueForKey("delete") as! Bool == true {
                dataAry.removeObjectAtIndex(i)
                
            }
        }
            tbView.reloadData()
    }
    @IBAction func actSaveMenu(sender: AnyObject) {
        let addAry = NSMutableDictionary()
        addAry.setObject(nameTextField.text!, forKey: "name")
        addAry.setObject(quantityTextField.text!, forKey: "quantity")
        addAry.setObject(false, forKey: "delete")
        dataAry.addObject(addAry)
        tbView.reloadData()
    }
    @IBAction func actPrevious(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true) 
    }
    @IBAction func actSaveFoodEat(sender: AnyObject) {

        formatter.dateFormat = "a hh:mm"
        
        timeText = formatter.stringFromDate(datePickerView.date)
        
        
//        let path = getFileName("BabyEatList.plist")
//        foodEatDic = NSMutableDictionary()
//        foodEatDic.removeAllObjects()
//        foodEatDic = [:]
//        
//        foodEatDic.setObject(titleText, forKey: "title")
//        foodEatDic.setObject(imageText, forKey: "image")
//        foodEatDic.setObject(timeText, forKey: "time")
//        foodEatAry.addObject(foodEatDic)
//        
//        foodEatAry.writeToFile(path, atomically: true)

        let foodA: FavorFood = NSEntityDescription.insertNewObjectForEntityForName("FavorFood", inManagedObjectContext: contextA!) as! FavorFood
        foodA.date = AnalysisViewController.SELECTDATE
        foodA.time = timeText
        foodA.name = titleText
        AnalysisDetailViewController.PRIMEKEY++
        foodA.primeKey = AnalysisDetailViewController.PRIMEKEY
        
        appDel.saveContext()
        
        let alert = UIAlertView(title: "저장", message: "저장 완료 되었습니다!", delegate: self, cancelButtonTitle: "확인")
        alert.show()
        
    }
//    func getFileName(fileName:String) -> String {
//        let docsDir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
//        let docPath = docsDir[0] 
//        let fullName = docPath.stringByAppendingString(fileName)
//        return fullName
//    }
}
