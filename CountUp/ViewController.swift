//
//  ViewController.swift
//  CountUp
//
//  Created by Alexander Griswold on 7/16/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit
import RealmSwift 

class ViewController: UIViewController {
    
    
   //UIStuff
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var submitDate: UIButton!
    @IBOutlet weak var numberCounter: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var secondsButton: UIButton!
    @IBOutlet weak var minutesButton: UIButton!
    @IBOutlet weak var hoursButton: UIButton!
    @IBOutlet weak var daysButton: UIButton!
    
    @IBOutlet weak var buttonViewWidth: NSLayoutConstraint!
    
    @IBOutlet var buttonViewVerticalSpacing: NSLayoutConstraint!
    
    
   
    
    
    @IBOutlet var buttonViewHeight: NSLayoutConstraint!
    
    //persist stuff
    let realm = try! Realm()
    var startDate: Date?
    
    
    //so that the right thing can be displayed
    var secondsPressed = false
    var minutesPressed = false
    var hoursPressed = false
    var daysPressed = true
    
    var fontReducer = FontReducer()
    
    var dateSet = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
        
        
        //add curved edges to button view
        buttonView.layer.cornerRadius = buttonView.frame.width * 0.05
        
        daysLabel.isHidden = true
        submitDate.isHidden = true
        numberCounter.isHidden = true
        
        //numberCounter.alpha = 1
        datePicker.isHidden = true
        secondsButton.isHidden = true
        minutesButton.isHidden = true
        hoursButton.isHidden = true
        daysButton.isHidden = true
        
        
        
        /*
        UIView.animate(withDuration: 0.5, animations: {
            self.buttonViewHeight = 
        })
        */
        
       
        let when = DispatchTime.now() + 5// change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.buttonViewHeight.isActive = false
            self.buttonViewVerticalSpacing.isActive = false
            UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
                self.buttonView.frame.size.height = 46
                self.buttonView.frame.origin.y += 12
            }, completion: {(finished: Bool) in
                self.buttonViewVerticalSpacing.constant = 20
                self.buttonViewVerticalSpacing.isActive = true
                self.buttonViewHeight.constant = 46
                self.buttonViewHeight.isActive = true
                
                
            })
        }
        
        /*
        //setButtonViewAlpha(alpha: 0)
        
        fontReducer.reduceLabelFontSize(label: numberCounter)
        
        
        
        numberCounter.alpha = 0
        daysLabel.alpha = 0
        
        
        datePicker.setValue(UIColor.white, forKey: "textColor")
        
        
        
        
        
        let realmDate = realm.objects(RealmNumber.self)
        

        
        
        if realmDate.count == 0 {
            datePicker.isHidden = false
            dateSet = false
            
        
            
        } else {
            
            startDate = realmDate[0].startingTime
            print(realmDate[0].startingTime)
            let myDate = Date()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day], from: startDate!, to: myDate)
            //print(components.second!)
            numberCounter.text = String(components.day!)
            dateSet = true
        }
        

        */
        
        
        
 
        //_ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.count), userInfo: nil, repeats: true)
    }
    
    func hideButtonPanel() {
        
    }
    
    func setButtonViewAlpha(alpha: CGFloat) {
        secondsButton.alpha = alpha
        minutesButton.alpha = alpha
        hoursButton.alpha = alpha
        daysButton.alpha = alpha
        buttonView.alpha = alpha
    }
    
    
    
    func count() {
        
        
        if dateSet == true {
            changeTime()
        }
        
        
        
        //print(components.second!)
        
    }

    
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    
    
    @IBAction func submitDatePressed(_ sender: Any) {
        
        self.daysLabel.alpha = 0
        self.numberCounter.alpha = 0
        dateSet = true
        
        //save the number to realm
        let realmStartingDate = RealmNumber()
        realmStartingDate.startingTime = datePicker.date
        try! realm.write {
            realm.add(realmStartingDate)
        }
        
        //set up the date
        startDate = realmStartingDate.startingTime
        let myDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate!, to: myDate)
        numberCounter.text = String(components.day!)
        fontReducer.reduceLabelFontSize(label: numberCounter)
        
        //animate the stuff off the screen
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.submitDate.frame.origin.y += 1000
            self.datePicker.frame.origin.y -= 1000
            
        }, completion: { (finished: Bool) in
            UIView.animate(withDuration: 1, animations: {
                
                self.submitDate.alpha = 0
                self.datePicker.alpha = 0
                
                //make the other stuff fade in
                self.daysLabel.alpha = 1
                self.numberCounter.alpha = 1
                self.setButtonViewAlpha(alpha: 1)
            })
        })
    }
    
    
    @IBAction func resetPressed(_ sender: Any) {
        try! realm.write {
            realm.deleteAll()
        }
        
        self.submitDate.frame.origin.y -= 1000
        self.datePicker.frame.origin.y += 1000
        
        self.daysLabel.alpha = 0
        self.numberCounter.alpha = 0
        setButtonViewAlpha(alpha: 0)
        
        //numberCounter.isHidden = true
        //daysLabel.isHidden = true
        datePicker.isHidden = false
        submitDate.isHidden = false
        dateSet = false

    }
    
    @IBAction func secondsPressed(_ sender: Any) {
        secondsPressed = true
        minutesPressed = false
        hoursPressed = false
        daysPressed = false
        changeTime()
    }
    
    @IBAction func minutesPressed(_ sender: Any) {
        secondsPressed = false
        minutesPressed = true
        hoursPressed = false
        daysPressed = false
        changeTime()
    }
    
    @IBAction func hoursPressed(_ sender: Any) {
        secondsPressed = false
        minutesPressed = false
        hoursPressed = true
        daysPressed = false
        changeTime()
    }
    
    @IBAction func daysPressed(_ sender: Any) {
        secondsPressed = false
        minutesPressed = false
        hoursPressed = false
        daysPressed = true
        changeTime()
    }
    

}

