//
//  DateSelectorView.swift
//  CountUp
//
//  Created by Alexander Griswold on 8/23/18.
//  Copyright © 2018 com.example. All rights reserved.
//

import UIKit

class DateSelectorView: UIView {
    
    weak var delegate: SubmitButtonDelegate? = nil
    
    let dateSelector: UIDatePicker = {
        let dateSelector = UIDatePicker(frame: .zero)
        dateSelector.setValue(UIColor.white, forKey: "textColor")
        let twoThousandYears: TimeInterval = (60 * 60 * 24) * 365 * 2000
        dateSelector.maximumDate = Date(timeIntervalSinceNow: twoThousandYears)
        dateSelector.translatesAutoresizingMaskIntoConstraints = false
        dateSelector.datePickerMode = .date
        return dateSelector
    }()
    
    let submitBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 30.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let submitButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(SystemColors().main, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.setTitle("Submit Date", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = SystemColors().main
        [dateSelector, submitBackground, submitButton].forEach { self.addSubview($0) }
        setupAutoLayout()
        submitButton.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAutoLayout() {
        dateSelector.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dateSelector.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        submitBackground.widthAnchor.constraint(equalToConstant: 280).isActive = true
        submitBackground.heightAnchor.constraint(equalToConstant: 60).isActive = true
        submitBackground.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        submitBackground.topAnchor.constraint(equalTo: centerYAnchor, constant: 130).isActive = true
        
        submitButton.centerYAnchor.constraint(equalTo: submitBackground.centerYAnchor).isActive = true
        submitButton.centerXAnchor.constraint(equalTo: submitBackground.centerXAnchor).isActive = true
        submitButton.widthAnchor.constraint(equalTo: submitBackground.widthAnchor).isActive = true
        submitButton.heightAnchor.constraint(equalTo: submitBackground.heightAnchor).isActive = true
    }
    
    @objc func didTapSubmit() {
        
      
        
        delegate?.didTapSubmit(compareDate: dateSelector.date)
    }
}

protocol SubmitButtonDelegate: class {
    func didTapSubmit(compareDate: Date)
}
