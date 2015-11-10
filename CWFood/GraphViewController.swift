//
//  GraphViewController.swift
//  CWFood
//
//  Created by 김대호 on 2015. 7. 31..
//  Copyright (c) 2015년 김대호. All rights reserved.
//

import UIKit
import JBChart

class GraphViewController : UIViewController, JBBarChartViewDelegate, JBBarChartViewDataSource  {
    //@IBOutlet weak var needLabel: UILabel!
    @IBOutlet weak var barChar: JBBarChartView!

    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var recomandScrollView: UIScrollView!
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var explainTextView: UITextView!
    @IBOutlet weak var threeEnergyBtn: UIButton!
    @IBOutlet weak var vitaminBtn: UIButton!
    @IBOutlet weak var recomandText: UILabel!
//    @IBOutlet weak var graphScrollView: UIScrollView!
    
    
    @IBOutlet weak var mugiBtn: UIButton!
    var chartLegend : NSMutableArray = ["칼로리", "단백질","탄수화물","지방"]
    var chartData : NSMutableArray = [70,80,40,50,20,25,25,30]
    
    let chartImportLegend = ["칼로리", "단백질","탄수화물","지방"]
    
    let chartVitaminLegend = ["비타민A","비타민B1","비타민B2","비타민B6","비타민C","비타민D","비타민E","비타민K"]
    
    let chartMugiLegend = ["칼슘","인","미네랄","철"]
    
    let chartImportData = [75,80,40,50,20,25,25,30]
    
    let chartVitaminData = [45,50,40,50,80,90,30,40,50,60,40,20,70,75,25,30]
    
    let chartMugiData = [30,40,40,60,15,30,25,30]
    
    var isVita : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        recomandScrollView.contentSize = CGSizeMake(480, 128)
        recomandScrollView.hidden = true
        contentScrollView.contentSize = CGSize(width: 375, height: 828)
        barChar.backgroundColor = UIColor.whiteColor()
        barChar.delegate = self
        barChar.dataSource = self
        barChar.minimumValue = 0
        barChar.maximumValue = 100
   
        

        addFooter()
        
        barChar.reloadData()
        
//        barChar.headerView = header

        barChar.setState(JBChartViewState.Collapsed, animated: false)
        
        threeEnergyBtn.layer.borderWidth = 0.5
        threeEnergyBtn.layer.borderColor = UIColor.lightGrayColor().CGColor
        vitaminBtn.layer.borderWidth = 0.5
        vitaminBtn.layer.borderColor = UIColor.lightGrayColor().CGColor
        mugiBtn.layer.borderWidth = 0.5
        mugiBtn.layer.borderColor = UIColor.lightGrayColor().CGColor

    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        

        //our code
        
        barChar.reloadData()
//        var timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("showChart"), userInfo: nil, repeats: false)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        hideChart()
    }
    func hideChart() {
        self.barChar.setState(JBChartViewState.Collapsed, animated: true)
    }
    func showChart(){
        barChar.setState(JBChartViewState.Expanded, animated: true)
    }
    
    //MARK: JBBarChartView
    func numberOfBarsInBarChartView(barChartView: JBBarChartView!) -> UInt {
        return UInt(chartData.count)
    }
    func barChartView(barChartView: JBBarChartView!, heightForBarViewAtIndex index: UInt) -> CGFloat {
        
        return CGFloat(chartData[Int(index)] as! NSNumber)
    }
    func barChartView(barChartView: JBBarChartView!, colorForBarViewAtIndex index: UInt) -> UIColor! {
        let num : Int = Int(index)
        
//        if (index % 2 != 0) {
//            if ((chartData[num] as! Int) > (chartData[num-1] as! Int)) {
//                //return UIColor(red: 150/255, green: 97/255, blue: 154/255, alpha: 1)
//            }else {
//                //return UIColor(red: 219/255, green: 38/255, blue: 0/255, alpha: 1)
//            }
//            
//        }else {
//            return UIColor(red: 252/255, green: 204/255, blue: 82/255, alpha: 1)
//        }
        if (index % 2 == 0){
            return UIColor(red: 252/255, green: 204/255, blue: 82/255, alpha: 1)
        }else {
            if ((chartData[num] as! Int) < (chartData[num-1] as! Int)) {
                return UIColor(red: 217/255, green: 38/255, blue: 13/255, alpha: 0.8)
            }else{
                return UIColor(red: 67/255, green: 162/255, blue: 128/255, alpha: 1)
            }
            
        }
    }
    func barChartView(barChartView: JBBarChartView!, didSelectBarAtIndex index: UInt) {
        //let data: AnyObject = chartData[Int(index)]
        let key: String = (chartLegend[Int(index/2)] as? String)!
        let findMyPos = index/2
        if (findMyPos == 5) {
        
        
        let explain = "비타민 D는 칼슘과 인의 대사를 조절하여 아이의 뼈 건강에 아주 중요한 역할을 합니다\n\n 이러한 비타민 D는 생선이다 달걀에 풍부하게 함유되어 있는데요, 이를 참고하여 우리아이 이슈식을 준비하는게 어떠세요?\n\n 아 또한 비타민 D의 식품 외에도 햇빛을 받음으로서 합성이 가능해요, 하루 30분정도 야외에서의 활동은 아이 뼈건강에 많은 도움이 될 수 있어요!"
        recomandText.text = "추천이유식"
       
        explainTextView.text = explain
        titleImage.hidden = false
        recomandScrollView.hidden = false

        }else {
            let needText = "필요 권장량 : 10ug"
            let explain = "정상이군요!"
        
            explainTextView.text = explain
        titleImage.hidden = true
        recomandScrollView.hidden = true

        }
        
        
        //imformationLabel.text = "\(key) : \(data)"
        
    }
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        let indexPage = scrollView.contentOffset.y / scrollView.frame.height
//        let indexHeight = indexPage*667
//        if(indexHeight < 150){
//            UIView.animateWithDuration(0.5, delay: 0.00, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: nil, animations: {
//                self.contentScrollView.transform = CGAffineTransformMakeTranslation(0,-indexHeight*3)
//                self.grahpScrollView.transform = CGAffineTransformMakeTranslation(0,-indexHeight)
//                }, completion: nil)
//        }else {
//
//        }
//        

//    }

    func addFooter() {
        let footerView = UIView(frame: CGRectMake(0, 0, barChar.frame.width, 16))
        for (var i = 0; i < chartData.count/2 ; i++){
            let footer = UILabel(frame: CGRectMake(barChar.frame.width/CGFloat(chartData.count/2)*CGFloat(i), 0, barChar.frame.width/CGFloat(chartData.count/2), 16))
            footer.text = "\(chartLegend[i])"
            footer.font = UIFont.systemFontOfSize(11)
            footer.textAlignment = NSTextAlignment.Center
            //footer.adjustsFontSizeToFitWidth = true
            footerView.addSubview(footer)
        }
        barChar.footerView = footerView
    }
    @IBAction func actPrevious(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func actImportBtn(sender: AnyObject) {
        
        threeEnergyBtn.backgroundColor = UIColor(red: 245/255, green: 168/255, blue: 35/255, alpha: 1)
        threeEnergyBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        vitaminBtn.backgroundColor = UIColor.whiteColor()
        vitaminBtn.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        mugiBtn.backgroundColor = UIColor.whiteColor()
        mugiBtn.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        
//        graphScrollView.contentSize = CGSize(width: 365, height: 200)
//        barChar.frame.size = CGSizeMake(365, 200)
        chartLegend.removeAllObjects()
        chartData.removeAllObjects()
        chartLegend.addObjectsFromArray(chartImportLegend)
        chartData.addObjectsFromArray(chartImportData)
        addFooter()
        barChar.setState(JBChartViewState.Collapsed, animated: false)

        barChar.reloadData()
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("showChart"), userInfo: nil, repeats: false)
    }
    @IBAction func actVitaminBtn(sender: AnyObject) {
        threeEnergyBtn.backgroundColor = UIColor.whiteColor()
        threeEnergyBtn.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        vitaminBtn.backgroundColor = UIColor(red: 245/255, green: 168/255, blue: 35/255, alpha: 1)
        vitaminBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        mugiBtn.backgroundColor = UIColor.whiteColor()
        mugiBtn.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)

 //       graphScrollView.contentSize = CGSize(width: 1095, height: 200)
 //       barChar.frame.size = CGSizeMake(700, 200)
        chartLegend.removeAllObjects()
        chartData.removeAllObjects()
        chartLegend.addObjectsFromArray(chartVitaminLegend)
        chartData.addObjectsFromArray(chartVitaminData)
        addFooter()
        barChar.setState(JBChartViewState.Collapsed, animated: false)

        barChar.reloadData()
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("showChart"), userInfo: nil, repeats: false)
    }
    @IBAction func actMugiBtn(sender: AnyObject) {
        threeEnergyBtn.backgroundColor = UIColor.whiteColor()
        threeEnergyBtn.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        vitaminBtn.backgroundColor = UIColor.whiteColor()
        vitaminBtn.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        mugiBtn.backgroundColor = UIColor(red: 245/255, green: 168/255, blue: 35/255, alpha: 1)
        mugiBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)

 //       graphScrollView.contentSize = CGSize(width: 365, height: 200)
 //       barChar.frame.size = CGSizeMake(365, 200)
        chartLegend.removeAllObjects()
        chartData.removeAllObjects()
        chartLegend.addObjectsFromArray(chartMugiLegend)
        chartData.addObjectsFromArray(chartMugiData)
        addFooter()
        barChar.setState(JBChartViewState.Collapsed, animated: false)

        barChar.reloadData()
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("showChart"), userInfo: nil, repeats: false)
    }
}
