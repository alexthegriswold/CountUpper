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
   
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var submitDate: UIButton!

    let realm = try! Realm()
    
    var startDate: Date?
    
    var numberCounter = UILabel()
    
    var secondsPressed = false
    var minutesPressed = false
    var hoursPressed = false
    var daysPressed = true
    
    var counterOriginalXPosition = 0
    var dateLabelOriginalXPosition = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberCounter.alpha = 0
        daysLabel.alpha = 0
        
        
        datePicker.setValue(UIColor.white, forKey: "textColor")
        
        //view.backgroundColor = UIColor(colorLiteralRed: 0, green: 217, blue: 255, alpha: 1)
        //numberCounter.backgroundColor = UIColor.red
        numberCounter.text = ""
        numberCounter.textColor = UIColor.white
        numberCounter.numberOfLines = 0
        numberCounter.textAlignment = .center
        numberCounter.font = UIFont.systemFont(ofSize: 200, weight: UIFontWeightLight)
        numberCounter.backgroundColor = UIColor.red
        numberCounter.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(numberCounter)
        
       
        numberCounter.adjustsFontSizeToFitWidth = true
        numberCounter.minimumScaleFactor = 0.3
        
        let widthConstraint = NSLayoutConstraint(item: numberCounter, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 300)
        let heightConstraint = NSLayoutConstraint(item: numberCounter, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 200)
        var constraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[superview]-(<=1)-[label]",
            options: NSLayoutFormatOptions.alignAllCenterX,
            metrics: nil,
            views: ["superview":view, "label":numberCounter])
        
        view.addConstraints(constraints)
        
        // Center vertically
        constraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:[superview]-(<=1)-[label]",
            options: NSLayoutFormatOptions.alignAllCenterY,
            metrics: nil,
            views: ["superview":view, "label":numberCounter])
        
        view.addConstraints(constraints)
        
        view.addConstraints([ widthConstraint, heightConstraint])
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let realmDate = realm.objects(RealmNumber.self)
        
        
        let bottomDayContraint = NSLayoutConstraint(item: daysLabel, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: numberCounter, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: -45)
        
        
        
        NSLayoutConstraint(item: daysLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0).isActive = true
        //daysLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        view.addConstraint(bottomDayContraint)
        
        
        //daysLabel.bottomAnchor = 1.0 * numberCounter.topAnchor + 15
        
        //let realmStartingDate = RealmNumber()
        //realmStartingDate.startingTime = Date()
        
        
        if realmDate.count == 0 {
            datePicker.isHidden = false
            
        
            
        } else {
            
            startDate = realmDate[0].startingTime
            print(realmDate[0].startingTime)
            let myDate = Date()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day], from: startDate!, to: myDate)
            //print(components.second!)
            numberCounter.text = String(components.day!)
        }
        
        counterOriginalXPosition = Int(numberCounter.frame.origin.x)
        dateLabelOriginalXPosition = Int(daysLabel.frame.origin.x)
        
        
        
        
 
        //_ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.count), userInfo: nil, repeats: true)
    }
    
    func count() {
        
        
        print(datePicker.date)
        changeTime()
        
        
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
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func seconds(_ sender: Any) {
        secondsPressed = true
        minutesPressed = false
        hoursPressed = false
        daysPressed = false
        changeTime()
        
    }
    @IBAction func minutes(_ sender: Any) {
        secondsPressed = false
        minutesPressed = true
        hoursPressed = false
        daysPressed = false
        changeTime()
        
    }
    @IBAction func hours(_ sender: Any) {
        secondsPressed = false
        minutesPressed = false
        hoursPressed = true
        daysPressed = false
        changeTime()
        
    }
    @IBAction func days(_ sender: Any) {
        secondsPressed = false
        minutesPressed = false
        hoursPressed = false
        daysPressed = true
        changeTime()
        
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func submitDatePressed(_ sender: Any) {
        
        self.daysLabel.alpha = 0
        self.numberCounter.alpha = 0    
        
        let realmStartingDate = RealmNumber()
        realmStartingDate.startingTime = datePicker.date
        // Persist your data easily
        try! realm.write {
            realm.add(realmStartingDate)
        }
        startDate = realmStartingDate.startingTime
        let myDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.second], from: startDate!, to: myDate)
        numberCounter.text = String(components.second!)
        
        //numberCounter.isHidden = false
        //daysLabel.isHidden = false
        //daysLabel.alpha = 0
        //datePicker.isHidden = true
        //submitDate.isHidden = true
        
        
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.submitDate.frame.origin.y += 1000
            self.datePicker.frame.origin.y -= 1000
            
        }, completion: { (finished: Bool) in
            UIView.animate(withDuration: 1, animations: {
                self.daysLabel.alpha = 1
                self.numberCounter.alpha = 1
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
        
        //numberCounter.isHidden = true
        //daysLabel.isHidden = true
        datePicker.isHidden = false
        submitDate.isHidden = false
        
        print("pressed")
    }
    

}

