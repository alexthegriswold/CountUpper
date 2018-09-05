//
//  ViewController.swift
//  CountUp
//
//  Created by Alexander Griswold on 7/16/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var buttonsLRConstant = CGFloat(250)
    
   //UIStuff
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var submitDate: UIButton!
    @IBOutlet weak var numberCounter: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!

    @IBOutlet weak var secondsButton: UIButton!
    @IBOutlet weak var minutesButton: UIButton!
    @IBOutlet weak var hoursButton: UIButton!
    @IBOutlet weak var daysButton: UIButton!
    
    @IBOutlet var buttonView: UIView!
    @IBOutlet var buttonViewWidth: NSLayoutConstraint!

    @IBOutlet var buttonViewHeight: NSLayoutConstraint!
    
    @IBOutlet var buttonViewTop: NSLayoutConstraint!
    
    @IBOutlet var secondsButtonLeft: NSLayoutConstraint!
    
    @IBOutlet var submitDateTop: NSLayoutConstraint!
    
    @IBOutlet var submitDateLeft: NSLayoutConstraint!
    
    @IBOutlet var submitDateLabel: UILabel!
    
    @IBOutlet var barButtonView: UIView!
    
    var startDate: Date?
    
    
    //so that the right thing can be displayed
    var secondsPressed = false
    var minutesPressed = false
    var hoursPressed = false
    var daysPressed = true
    
    var fontReducer = FontReducer()
    
    var dateSet = false
    
    var intSeconds = 0
    var intMinutes = 0
    var intHours = 0
    var intDays = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        daysLabel.text = "Days Since"
        
        buttonView.layer.cornerRadius = buttonView.frame.size.height * 0.2
        fontReducer.reduceLabelFontSize(label: numberCounter)
        datePicker.setValue(UIColor.white, forKey: "textColor")
        
        
        barButtonView.alpha = 0
        setButtonViewAlpha(alpha: 0)
        daysLabel.alpha = 0
        numberCounter.alpha = 0
        submitDateLabel.alpha = 0
    
        datePicker.isHidden = false
        dateSet = false
        
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.count), userInfo: nil, repeats: true)
    }
    
    func moveTimeButtonsFoward(amountFoward: CGFloat) {
        self.secondsButton.frame.origin.x += amountFoward
        self.minutesButton.frame.origin.x += amountFoward
        self.hoursButton.frame.origin.x += amountFoward
        self.daysButton.frame.origin.x += amountFoward
    }
    
    func count() {        
        if secondsPressed {
            changeTime()
        }
    }
    
    func setButtonViewAlpha(alpha: CGFloat) {
        secondsButton.alpha = alpha
        minutesButton.alpha = alpha
        hoursButton.alpha = alpha
        daysButton.alpha = alpha
    }
    
    //this needs to be changed to allow for the safe calculating of dates 
    
    func changeTime() {
        let myDate = Date()
        let calendar = Calendar.current
        let components1 = calendar.dateComponents([.second], from: startDate!, to: myDate)
        let components2 = calendar.dateComponents([.minute], from: startDate!, to: myDate)
        let components3 = calendar.dateComponents([.hour], from: startDate!, to: myDate)
        let components4 = calendar.dateComponents([.day], from: startDate!, to: myDate)
        
        if secondsPressed == true {
            numberCounter.text = String(components1.second!)
            
        } else if minutesPressed == true {
            numberCounter.text = String(components2.minute!)
            
        } else if hoursPressed == true {
            numberCounter.text = String(components3.hour!)
            
        } else if daysPressed == true {
            numberCounter.text = String(components4.day!)
            
        }
        fontReducer.reduceLabelFontSize(label: numberCounter)
    }
    
    
    func divideTime() {
        let calendar = Calendar.current
        let yearsComponent = calendar.dateComponents([.year], from: startDate!)
       
        var myDate = startDate
        var date50Year = Date()

        var amountOfYears = yearsComponent.year
        
        print(amountOfYears)
        
        while amountOfYears! < 1975 {
            
            myDate = calendar.date(byAdding: .year , value: +50, to: myDate!)
            amountOfYears! += 50
            print("Int Version: ", amountOfYears!)
            let newYearsComponent = calendar.dateComponents([.year], from: myDate!)
            print("Date Version: ", newYearsComponent.year)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    @IBAction func submitDatePressed(_ sender: Any) {
        
        dateSet = true
       
        let gregorian = Calendar(identifier: .gregorian)
        let now = Date()
        
    
        startDate = datePicker.date
        let myDate = Date()
        let calendar = Calendar.current
        
        divideTime()
        
        let components = calendar.dateComponents([.day], from: startDate!, to: myDate)
        
        var newDate = calendar.date(bySetting: .hour, value: 0, of: startDate!)
        newDate = calendar.date(bySetting: .minute, value: 0, of: newDate!)
        newDate = calendar.date(bySetting: .second, value: 0, of: newDate!)
        
        
        
        let components3 = calendar.dateComponents([.hour], from: newDate!, to: myDate)
        
        print(components3)
        
        
        numberCounter.text = String(components.day!)
        fontReducer.reduceLabelFontSize(label: numberCounter)

        view.layoutSubviews()
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            
                self.barButtonView.alpha = 1
                self.buttonView.frame.size.width = 241
                self.buttonView.frame.size.height = 49
                self.buttonView.frame.origin.y += 13
                self.buttonView.frame.origin.x += 19.5
                self.submitDate.alpha = 0
                self.datePicker.alpha = 0
 
            }, completion: {(finished: Bool) in
                
                self.buttonViewHeight.constant = 49
                self.buttonViewWidth.constant = 241
                self.buttonViewTop.constant = 33
                self.moveTimeButtonsFoward(amountFoward: -250)
                self.setButtonViewAlpha(alpha: 1)
                self.view.layoutSubviews()
                
                UIView.animate(withDuration: 0.5, animations: {
    
                    self.moveTimeButtonsFoward(amountFoward: self.buttonsLRConstant)
                    self.daysLabel.alpha = 1
                    self.numberCounter.alpha = 1
                    
                }, completion: {(finished: Bool) in
                    
                    self.secondsButtonLeft.constant = 8
                    self.view.layoutSubviews()
                    
                })
            })
    }
    
    
    
    
    @IBAction func resetPressed(_ sender: Any) {
        
        view.layoutSubviews()
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            
            self.barButtonView.alpha = 0
            self.moveTimeButtonsFoward(amountFoward: -250)
            self.datePicker.alpha = 0
            self.daysLabel.alpha = 0
            self.numberCounter.alpha = 0
            
            
        }, completion: {(finished: Bool) in
            
            
            self.setButtonViewAlpha(alpha: 0)
            self.view.layoutSubviews()
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.submitDate.alpha = 1
                self.datePicker.alpha = 1
                self.buttonView.frame.size.width = 280
                self.buttonView.frame.size.height = 75
                self.buttonView.frame.origin.y -= 13
                self.buttonView.frame.origin.x -= 19.5
                
                
            }, completion: {(finished: Bool) in
                
                
                self.buttonViewWidth.constant = 280
                self.buttonViewHeight.constant = 75
                self.buttonViewTop.constant = 20
                self.view.layoutSubviews()
                
            })
        })
        
        
        
        
        secondsPressed = false
        minutesPressed = false
        hoursPressed = false
        daysPressed = true
        
        dateSet = false
        

    }
    
    
    
    
    @IBAction func secondsPressed(_ sender: Any) {
        secondsPressed = true
        minutesPressed = false
        hoursPressed = false
        daysPressed = false
        changeTime()
        
        daysLabel.text = "Seconds Since"
    }
    
    @IBAction func minutesPressed(_ sender: Any) {
        secondsPressed = false
        minutesPressed = true
        hoursPressed = false
        daysPressed = false
        changeTime()
        
        daysLabel.text = "Minutes Since"
    }
    
    @IBAction func hoursPressed(_ sender: Any) {
        secondsPressed = false
        minutesPressed = false
        hoursPressed = true
        daysPressed = false
        changeTime()
        
        daysLabel.text = "Hours Since"
    }
    
    @IBAction func daysPressed(_ sender: Any) {
        secondsPressed = false
        minutesPressed = false
        hoursPressed = false
        daysPressed = true
        changeTime()
        
        daysLabel.text = "Days Since"
    }
    

}

