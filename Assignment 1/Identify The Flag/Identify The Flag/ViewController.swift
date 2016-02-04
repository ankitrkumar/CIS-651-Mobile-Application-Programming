//
//  ViewController.swift
//  Identify The Flag
//
//  Created by Ankit Kumar on 2/3/16.
//  Copyright © 2016 Ankit Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate,UIPickerViewDataSource, UIPickerViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var countryPickerView: UIPickerView!
    
    let flagNames = ["India", "China", "Ethiopia", "USA", "Japan", "France", "Germany", "UK", "Italy", "Denmark", "Belgium", "Belarus", "Vietnam", "Syria", "Pakistan", "Nigeria", "Singapore"]
    
    let flagImages = ["India.png", "China.png", "Ethiopia.png", "USA.png", "Japan.png", "France.png", "Germany.png", "UK.png", "Italy.png", "Denmark.png", "Belgium.png", "Belarus.png", "Vietnam.png", "Syria.png", "Pakistan.png", "Nigeria.png", "Singapore.png"]
    
    var currentFlag = "Germany"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryTextField.delegate = self
        currentFlag = flagImages[random() % flagImages.count]
        flagImageView.image = UIImage(named:currentFlag)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("newFlag:"))
        flagImageView.userInteractionEnabled = true
        flagImageView.addGestureRecognizer((tapGestureRecognizer))
        
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        countryTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if currentFlag[currentFlag.startIndex..<currentFlag.endIndex.advancedBy(-4)].lowercaseString == countryTextField.text?.lowercaseString
        {
            countryTextField.text! += "... correct ✔️"
        }
        else
        {
            countryTextField.text! += "... incorrect ✖️"
        }
    }
    
    func newFlag(img: AnyObject)
    {
        flagImageView.image = randomflagImagePicker()
        countryTextField.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UIPickerView
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return flagNames.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return flagNames[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryTextField.text = flagNames[row]
        
        if currentFlag[currentFlag.startIndex..<currentFlag.endIndex.advancedBy(-4)].lowercaseString == flagNames[row].lowercaseString
        {
            countryTextField.text! += " correct ✔️"
            
        }
        else
        {
            countryTextField.text! += " incorrect ✖️"
        }
        
    }
    
    //MARK : Model
    
    func randomflagImagePicker() -> UIImage
    {
        currentFlag = flagImages[random() % flagImages.count]
        return UIImage(named:currentFlag)!
    }
    
    
}

