//
//  AnalysisViewController.swift
//  CWFood
//
//  Created by 김대호 on 2015. 7. 24..
//  Copyright (c) 2015년 김대호. All rights reserved.
//

import UIKit
import CoreData

class AnalysisViewController : UIViewController,UITableViewDataSource, UITableViewDelegate , CLWeeklyCalendarViewDelegate {
    
    static var SELECTDATE = ""
    
    @IBOutlet weak var tbView: UITableView!
    
    @IBOutlet weak var anysisBtn: UIButton!
    
    //CORE DATA
    var appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var contextA : NSManagedObjectContext?
    var foods : Array<FavorFood>!
    var selectDateFoods = NSMutableArray()
    //
    
    var calenderView : CLWeeklyCalendarView!
//    var dataAry : NSArray!
//    var foodEatAry : NSMutableArray!
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
        
        self.view.addSubview(calenderView)
    }
    override func viewWillAppear(animated: Bool) {
        //CORE DATA
        contextA = appDel.managedObjectContext
        let reqA: NSFetchRequest = NSFetchRequest(entityName:"FavorFood")
        foods = (try! contextA!.executeFetchRequest(reqA) as! Array<FavorFood>)
        //
        selectDateFoods.removeAllObjects()
        for(var i = 0; i < foods.count; i++){
            print(foods[i].name)
            print(foods[i].time)
            print(foods[i].date)
            if(foods[i].date == AnalysisViewController.SELECTDATE){
                selectDateFoods.addObject(foods[i])
            }
        }
        tbView.reloadData()
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCellWithIdentifier("WhatEatCell", forIndexPath: indexPath) as UITableViewCell
        
        let titleLabel = cell.viewWithTag(401) as! UILabel
        let timeLabel = cell.viewWithTag(402) as! UILabel
        
        titleLabel.text = selectDateFoods[indexPath.row].name
        timeLabel.text = selectDateFoods[indexPath.row].time
        
        return cell
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
//            foodEatAry.removeObjectAtIndex(indexPath.row)
//            let path = getFileName("BabyEatList.plist")
//            foodEatAry.writeToFile(path, atomically: true)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectDateFoods.count
    }
    
    func dailyCalendarViewDidSelect(date: NSDate!) {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        AnalysisViewController.SELECTDATE = formatter.stringFromDate(date)
        
        selectDateFoods.removeAllObjects()
        for(var i = 0; i < foods.count; i++){
            if(foods[i].date == AnalysisViewController.SELECTDATE){
                selectDateFoods.addObject(foods[i])
            }
        }
        tbView.reloadData()
    }
    
    @IBAction func actPrevious(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    func CLCalendarBehaviorAttributes() -> [NSObject : AnyObject]! {
        return [CLCalendarWeekStartDay : 2,
            CLCalendarDayTitleTextColor : UIColor.whiteColor(),
            CLCalendarSelectedDatePrintColor : UIColor.whiteColor()
            ];
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
