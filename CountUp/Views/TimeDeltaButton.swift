//
//  TimeDeltaButton.swift
//  CountUp
//
//  Created by Alexander Griswold on 8/23/18.
//  Copyright © 2018 com.example. All rights reserved.
//

import UIKit

class TimeDeltaButton: UIButton {
    
    let timeDelta: TimeDeltaButtonType
    weak var delegate: TimeDeltaButtonDelegate? = nil
    
    init(timeDelta: TimeDeltaButtonType) {
        self.timeDelta = timeDelta
        super.init(frame: .zero)
        setTitle(timeDelta.rawValue, for: .normal)
        setTitleColor(SystemColors().main, for: .normal)
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTap() {
        delegate?.didTapTimeDeltaButton(timeDelta: timeDelta)
    }
}

protocol TimeDeltaButtonDelegate: class {
    func didTapTimeDeltaButton(timeDelta: TimeDeltaButtonType)
}
