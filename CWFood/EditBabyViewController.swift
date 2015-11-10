//
//  EditBabyViewController.swift
//  CWFood
//
//  Created by 김대호 on 2015. 7. 8..
//  Copyright (c) 2015년 김대호. All rights reserved.
//

import UIKit

class EditBabyViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var favorDic : NSMutableDictionary!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var birthDayField: UITextField!
    @IBOutlet weak var sexField: UITextField!
    @IBOutlet weak var aliasField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var kgField: UITextField!
    @IBOutlet weak var aboField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.hidden = true
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
        
        nameField.delegate = self
        birthDayField.delegate = self
        sexField.delegate = self
        heightField.delegate = self
        aliasField.delegate = self
        kgField.delegate = self
        
        imageView.layer.cornerRadius = 37
        imageView.layer.masksToBounds = true
        
        
    }
    func getFileName(fileName:String) -> String {
        let docsDir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let docPath = docsDir[0] 
        let fullName = docPath.stringByAppendingString(fileName)
        return fullName
    }
    @IBAction func actPhoto(sender: AnyObject) {
        let alert = UIAlertController(title: "사진가져오기", message: "선택하시오.", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        
        let action1 = UIAlertAction(title: "취소", style: UIAlertActionStyle.Cancel, handler: nil)
        let action2 = UIAlertAction(title: "사진찍기", style: UIAlertActionStyle.Default, handler: action2Handler)
        let action3 = UIAlertAction(title: "앨범에서 가져오기", style: UIAlertActionStyle.Default, handler: action3Handler)
        
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        presentViewController(alert, animated: true, completion: nil)

    }
    func action2Handler(alert:UIAlertAction?){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func action3Handler(alert:UIAlertAction?){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func actEdit(sender: AnyObject) {
        let imageData = UIImagePNGRepresentation(imageView.image!)
        
        if imageData != nil {
           
            let path = getFileName("BabyProfile.plist")
            favorDic.removeAllObjects()
            favorDic.setObject(nameField.text!, forKey: "name")
            favorDic.setObject(birthDayField.text!, forKey: "birth")
            favorDic.setObject(sexField.text!, forKey: "sex")
            favorDic.setObject(heightField.text!, forKey: "height")
            favorDic.setObject(aliasField.text!, forKey: "alias")
            favorDic.setObject(kgField.text!, forKey: "kg")
            favorDic.setObject(aboField.text!, forKey: "abo")
            favorDic.setObject(imageData!, forKey: "image")
            favorDic.writeToFile(path, atomically: true)
        }else {
            let alert = UIAlertView(title: "오류", message: "사진을 올려주세요", delegate: self, cancelButtonTitle: "확인")
            alert.show()
        }
        navigationController?.popViewControllerAnimated(true)
        
    }
    @IBAction func actCancel(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }

}
