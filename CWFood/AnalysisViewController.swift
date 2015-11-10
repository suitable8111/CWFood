//
//  AnalysisViewController.swift
//  CWFood
//
//  Created by 김대호 on 2015. 7. 24..
//  Copyright (c) 2015년 김대호. All rights reserved.
//

import UIKit

class AnalysisViewController : UIViewController,UITableViewDataSource, UITableViewDelegate , CLWeeklyCalendarViewDelegate {
    @IBOutlet weak var tbView: UITableView!
    
    @IBOutlet weak var anysisBtn: UIButton!
    var calenderView : CLWeeklyCalendarView!
////    var dataAry : NSArray!
    var foodEatAry : NSMutableArray!
    var dateString = ""
    var count = 0
    let formatter = NSDateFormatter()
    
    func makeCalender() -> CLWeeklyCalendarView {
        if !(calenderView != nil) {
            calenderView = CLWeeklyCalendarView(frame: CGRectMake(0, 60, self.view.bounds.size.width, 140))
            calenderView.delegate = self
        }
        return calenderView
    }
    
    override func viewDidLoad() {
        makeCalender()
        formatter.dateFormat = "yyyy-MM-dd"
        tbView.dataSource = self
        tbView.delegate = self
        calenderView.delegate = self
        anysisBtn.layer.cornerRadius = 5
        anysisBtn.layer.masksToBounds = true
////        let url = NSBundle.mainBundle().URLForResource("BabyEatTest1", withExtension: "plist")
////        dataAry = NSArray(contentsOfURL: url!)
        

        self.view.addSubview(calenderView)
    }
    override func viewWillAppear(animated: Bool) {
        let path = getFileName("BabyEatList.plist")
        let fileManager = NSFileManager.defaultManager()
        
        if(!fileManager.fileExistsAtPath(path)){
            let orgPath = NSBundle.mainBundle().pathForResource("BabyEatList", ofType: "plist")
            do {
                try fileManager.copyItemAtPath(orgPath!, toPath: path)
            } catch _ {
            }
        }
        foodEatAry = NSMutableArray(contentsOfFile: path)
        tbView.reloadData()
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCellWithIdentifier("WhatEatCell", forIndexPath: indexPath) as UITableViewCell
        
        let titleLabel = cell.viewWithTag(401) as! UILabel
        let timeLabel = cell.viewWithTag(402) as! UILabel
        titleLabel.text = foodEatAry.objectAtIndex(indexPath.row).valueForKey("title") as? String
        timeLabel.text = foodEatAry.objectAtIndex(indexPath.row).valueForKey("time") as? String
        
//        titleLabel.text = dataAry.objectAtIndex(indexPath.row+count) as? String
        return cell
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            foodEatAry.removeObjectAtIndex(indexPath.row)
            let path = getFileName("BabyEatList.plist")
            foodEatAry.writeToFile(path, atomically: true)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodEatAry.count
//        return 3
    }
    
    func dailyCalendarViewDidSelect(date: NSDate!) {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let dateString = formatter.stringFromDate(date)
        print(dateString)
//        if count < dataAry.count - 3 {
//            count = count + 3
//            tbView.reloadData()
//        }

    }
    @IBAction func actPrevious(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    func CLCalendarBehaviorAttributes() -> [NSObject : AnyObject]! {
        return [CLCalendarWeekStartDay : 2,
            CLCalendarDayTitleTextColor : UIColor.whiteColor(),
            CLCalendarSelectedDatePrintColor : UIColor.whiteColor()
            ];
//            CLCalendarDayTitleTextColor : UIColor.whiteColor(),
//            CLCalendarSelectedDatePrintColor : UIColor.whiteColor()()]
    }
    @IBAction func actAddMenu(sender: AnyObject) {
    }
    func getFileName(fileName:String) -> String {
        let docsDir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let docPath = docsDir[0] 
        let fullName = docPath.stringByAppendingString(fileName)
        return fullName
    }
}
