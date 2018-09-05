//
//  CounterView.swift
//  CountUp
//
//  Created by Alexander Griswold on 8/22/18.
//  Copyright © 2018 com.example. All rights reserved.
//

import UIKit

class CounterView: UIView {
    
    weak var delegate: CounterViewDelegate? = nil
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 60, weight: UIFont.Weight.medium)
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.minimumScaleFactor = 0.60
        label.text = "Seconds Since"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "69"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 200, weight: UIFont.Weight.thin)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.minimumScaleFactor = 0.2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
   
    let buttonsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let buttonsContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .equalSpacing
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let timeDeltaButtons: [TimeDeltaButton] = {
        var buttons = [TimeDeltaButton]()
        let buttonTypes: [TimeDeltaButtonType] = [.second, .minute, .hour, .day]
        buttonTypes.forEach {
            buttons.append(.init(timeDelta: $0))
        }
        
        return buttons
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(SystemColors().main, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.medium)
        button.setTitle("New Date", for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let resetButtonBackground: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = SystemColors().main
        [buttonsView, titleLabel, numberLabel, resetButton, resetButtonBackground].forEach { addSubview($0) }
        addSubview(buttonsView)

        timeDeltaButtons.forEach { buttonsContainer.addArrangedSubview($0) }
        
        resetButton.addTarget(self, action: #selector(tappedReset), for: .touchUpInside)
        resetButtonBackground.addTarget(self, action: #selector(tappedReset), for: .touchUpInside)

        buttonsView.addSubview(buttonsContainer)
        setupAutoLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAutoLayout() {
        
        numberLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        numberLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85).isActive = true
        
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: numberLabel.topAnchor, constant: -20).isActive = true
        
        buttonsView.widthAnchor.constraint(equalToConstant: 280).isActive = true
        buttonsView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        buttonsView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        buttonsView.topAnchor.constraint(equalTo: centerYAnchor, constant: 130).isActive = true
        buttonsContainer.centerXAnchor.constraint(equalTo: buttonsView.centerXAnchor).isActive = true
        buttonsContainer.centerYAnchor.constraint(equalTo: buttonsView.centerYAnchor).isActive = true
        
        resetButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        if #available(iOS 11.0, *) {
            resetButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            resetButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
        resetButton.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        resetButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        resetButtonBackground.topAnchor.constraint(equalTo: resetButton.bottomAnchor).isActive = true
        resetButtonBackground.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        resetButtonBackground.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        resetButtonBackground.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
 
    }
 
    func resetView(title: String, number: String) {
        titleLabel.text = title
        numberLabel.text = number
    }
    
    func resetTime(number: String) {
        numberLabel.text = number
    }
    
    @objc func tappedReset() {
        delegate?.didTapReset()
    }

}

protocol CounterViewDelegate: class {
    func didTapReset()
}
