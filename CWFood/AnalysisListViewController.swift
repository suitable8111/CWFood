//
//  AnalysisDetailViewController.swift
//  CWFood
//
//  Created by 김대호 on 2015. 7. 24..
//  Copyright (c) 2015년 김대호. All rights reserved.
//

import UIKit
class AnalysisListViewController : UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tbView: UITableView!
    
    var dataAry : NSMutableArray!
 
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = getFileName("myFavoriteFood.plist")
        let fileManager = NSFileManager.defaultManager()
        
        if(!fileManager.fileExistsAtPath(path)){
            let orgPath = NSBundle.mainBundle().pathForResource("myFavoriteFood", ofType: "plist")
            do {
                try fileManager.copyItemAtPath(orgPath!, toPath: path)
            } catch _ {
            }
        }
        dataAry = NSMutableArray(contentsOfFile: path)

        tbView.delegate = self
        tbView.dataSource = self
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataAry.count

    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCellWithIdentifier("AnalysisCell", forIndexPath: indexPath) as UITableViewCell
        
        let textLabel = cell.viewWithTag(101) as! UILabel
        textLabel.text = dataAry.objectAtIndex(indexPath.row).valueForKey("title") as? String
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "goAnalysis"){
            let advControl = segue.destinationViewController as! AnalysisDetailViewController
            advControl.dataAry = dataAry.objectAtIndex(tbView.indexPathForSelectedRow!.row).valueForKey("includes") as! NSMutableArray
            advControl.titleText = dataAry.objectAtIndex(tbView.indexPathForSelectedRow!.row).valueForKey("title") as! String
            advControl.imageText = dataAry.objectAtIndex(tbView.indexPathForSelectedRow!.row).valueForKey("image") as! String
        }

    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            dataAry.removeObjectAtIndex(indexPath.row)
            let path = getFileName("myFavoriteFood.plist")
            dataAry.writeToFile(path, atomically: true)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
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
//        is_searching = false
//    @IBOutlet weak var uiSearchBar: UISearchBar!
//    var is_searching:Bool!
//    var searchingDataArray:NSMutableArray!

//        searchingDataArray = []
//        uiSearchBar.delegate = self
//        if is_searching == true {
//            return searchingDataArray.count
//        }else {
//            return dataAry.count
//        }
//       if is_searching == true {
//           textLabel.text = searchingDataArray.objectAtIndex(indexPath.row).valueForKey("title") as? String
//        }else {
//            textLabel.text = dataAry.objectAtIndex(indexPath.row).valueForKey("title") as? String
//        }

//    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
//        searchBar.resignFirstResponder()
//        self.view.endEditing(true)
//    }
//    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text.isEmpty {
//            is_searching = false
//            searchingDataArray = []
//            tbView.reloadData()
//        }else {
//            searchingDataArray.removeAllObjects()
//            for var index = 0; index < dataAry.count; index++ {
//                var currentString = dataAry.objectAtIndex(index).valueForKey("title") as! String
//                if currentString.lowercaseString.rangeOfString(searchText.lowercaseString) != nil {
//                    searchingDataArray.addObject(dataAry.objectAtIndex(index))
//                }
//            }
//            is_searching = true
//            tbView.reloadData()
//        }
//    }