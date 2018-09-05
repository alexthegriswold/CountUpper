//
//  CounterViewController.swift
//  CountUp
//
//  Created by Alexander Griswold on 8/23/18.
//  Copyright © 2018 com.example. All rights reserved.
//

import UIKit

class CounterViewController: UIViewController, CounterViewDelegate, TimeDeltaButtonDelegate {

    let counterView = CounterView()
    let dateCalculator = DateCalculator()
    let titleStringFormatter = TitleStringFormatter()
    let compareDate: Date
    
    var secondsTimer = Timer()
    var seconds: UInt64 = 0
    
    var currentTimeDelta: TimeDeltaButtonType = .day
    
    init(compareDate: Date) {
        self.compareDate = compareDate
        super.init(nibName: nil, bundle: nil)
        
        setCounterViewValues(timeDelta: .day)
        counterView.timeDeltaButtons.forEach { $0.delegate = self }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counterView.frame = self.view.frame
        self.view.addSubview(counterView)
        counterView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func didTapReset() {
        navigationController?.popViewController(animated: true)
    }
    
    func setCounterViewValues(timeDelta: TimeDeltaButtonType) {
        
        let timeDifference = dateCalculator.getTimeDifferences(for: .second, currentDate: Date(), compareDate: compareDate)
        let titleString = titleStringFormatter.formatString(for: timeDelta, with: timeDifference.timeDifferenceType)
        
        secondsTimer.invalidate()
        secondsTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(checkIfNumberLabelNeedsToChange), userInfo: nil, repeats: true)
        currentTimeDelta = timeDelta
        seconds = timeDifference.value
        let valueToDisplay = convertSecondsToCurrentTimeDelta()
        
        counterView.resetView(title: titleString, number: String(valueToDisplay))
    }
    
    @objc func checkIfNumberLabelNeedsToChange() {
        let valueToDisplay = convertSecondsToCurrentTimeDelta()
        counterView.resetTime(number: String(valueToDisplay))
    }
    
    func convertSecondsToCurrentTimeDelta() -> UInt64 {
        switch currentTimeDelta {
        case .second:
            seconds += 1
            return seconds
        case .minute:
            seconds += 1
            return UInt64(floor(Double(seconds/60)))
        case .hour:
            return UInt64(floor(Double(seconds/3600)))
        case .day:
            return UInt64(floor(Double(seconds/86400)))
        }
    }
    
    func didTapTimeDeltaButton(timeDelta: TimeDeltaButtonType) {
        setCounterViewValues(timeDelta: timeDelta)
    }
    
    @objc func increaseTime() {
        seconds += 1
        counterView.resetTime(number: String(seconds))
    }
}
