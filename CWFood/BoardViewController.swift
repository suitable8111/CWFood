//
//  BoardViewController.swift
//  CWFood
//
//  Created by 김대호 on 2015. 8. 11..
//  Copyright (c) 2015년 김대호. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tbView: UITableView!
    var dataAry : NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSBundle.mainBundle().URLForResource("BoardList", withExtension: "plist")
        dataAry = NSArray(contentsOfURL: url!)
        
        tbView.dataSource = self
        tbView.delegate = self
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tbView.dequeueReusableCellWithIdentifier("BoardCell", forIndexPath: indexPath) as? UITableViewCell
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "BoardCell")
        }
        
        let textLabel = cell?.viewWithTag(301) as! UILabel
        let nameLabel = cell?.viewWithTag(302) as! UILabel
        let timeLabel = cell?.viewWithTag(303) as! UILabel
        
        textLabel.text = dataAry.objectAtIndex(indexPath.row).valueForKey("title") as? String
        nameLabel.text = dataAry.objectAtIndex(indexPath.row).valueForKey("name") as? String
        timeLabel.text = dataAry.objectAtIndex(indexPath.row).valueForKey("time") as? String
        
        return cell!
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let bdVC = segue.destinationViewController as! BoardDetailViewController
        if segue.identifier == "goBoardDetail" {
            bdVC.dataDic = dataAry.objectAtIndex(self.tbView.indexPathForSelectedRow!.row) as! NSDictionary
        }
    }
    @IBAction func actPrevious(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataAry.count;
    }
}
