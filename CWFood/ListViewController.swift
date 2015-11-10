//
//  ListViewController.swift
//  CWFood
//
//  Created by 김대호 on 2015. 7. 20..
//  Copyright (c) 2015년 김대호. All rights reserved.
//

import UIKit

class ListViewController : UIViewController, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    @IBOutlet var uicollectionView: UICollectionView?
    @IBOutlet weak var searchBar: UISearchBar!
    var dataAry : NSArray!
    
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var midBtn: UIButton!
    @IBOutlet weak var lastBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSBundle.mainBundle().URLForResource("MidFoodList", withExtension: "plist")
        dataAry = NSArray(contentsOfURL: url!)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 6, bottom: 0, right:6)
        layout.itemSize = CGSize(width: 175, height: 180)
        
        uicollectionView = UICollectionView(frame: self.uicollectionView!.frame, collectionViewLayout: layout)
        uicollectionView!.dataSource = self
        uicollectionView!.delegate = self
        uicollectionView?.backgroundColor = UIColor.whiteColor()
        uicollectionView!.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        
        uicollectionView?.contentSize = CGSizeMake(375, 1227)
        self.view.addSubview(uicollectionView!)
        
        firstBtn.layer.borderWidth = 0.5
        firstBtn.layer.borderColor = UIColor.lightGrayColor().CGColor
        midBtn.layer.borderWidth = 0.5
        midBtn.layer.borderColor = UIColor.lightGrayColor().CGColor
        lastBtn.layer.borderWidth = 0.5
        lastBtn.layer.borderColor = UIColor.lightGrayColor().CGColor
        
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataAry.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = uicollectionView!.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        cell.backgroundColor = UIColor.whiteColor()
        cell.textLabel?.text = dataAry[indexPath.row].valueForKey("title") as? String
        cell.imageView?.image = UIImage(named: dataAry[indexPath.row].valueForKey("image") as! String)
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let dlControl = self.storyboard?.instantiateViewControllerWithIdentifier("DetailListViewController") as! DetailListViewController
        dlControl.dic = dataAry[indexPath.row] as! NSDictionary
         self.navigationController?.pushViewController(dlControl,animated: true)
    }
    @IBAction func actFirst(sender: AnyObject) {
        firstBtn.backgroundColor = UIColor(red: 245/255, green: 168/255, blue: 35/255, alpha: 1)
        firstBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        midBtn.backgroundColor = UIColor.whiteColor()
        midBtn.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        lastBtn.backgroundColor = UIColor.whiteColor()
        lastBtn.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        
        let url = NSBundle.mainBundle().URLForResource("FirstFoodList", withExtension: "plist")
        dataAry = NSArray(contentsOfURL: url!)
        uicollectionView?.reloadData()
    }
    @IBAction func actMid(sender: AnyObject) {
        firstBtn.backgroundColor = UIColor.whiteColor()
        firstBtn.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        midBtn.backgroundColor = UIColor(red: 245/255, green: 168/255, blue: 35/255, alpha: 1)
        midBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        lastBtn.backgroundColor = UIColor.whiteColor()
        lastBtn.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        
        let url = NSBundle.mainBundle().URLForResource("MidFoodList", withExtension: "plist")
        dataAry = NSArray(contentsOfURL: url!)
        uicollectionView?.reloadData()
    }
    @IBAction func actLast(sender: AnyObject) {
        firstBtn.backgroundColor = UIColor.whiteColor()
        firstBtn.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        midBtn.backgroundColor = UIColor.whiteColor()
        midBtn.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        lastBtn.backgroundColor = UIColor(red: 245/255, green: 168/255, blue: 35/255, alpha: 1)
        lastBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        let url = NSBundle.mainBundle().URLForResource("LastFoodList", withExtension: "plist")
        dataAry = NSArray(contentsOfURL: url!)
        uicollectionView?.reloadData()
    }

    @IBAction func actPrevious(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
   
}