//
//  FontReducer.swift
//  CountUp
//
//  Created by Alexander Griswold on 7/23/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class FontReducer {
    func reduceLabelFontSize(label: UILabel) {
        
        let characterCount = label.text?.characters.count
        if characterCount! < 3 {
            label.font = UIFont.systemFont(ofSize: 200, weight: UIFontWeightThin)
        } else if characterCount == 3 {
            label.font = UIFont.systemFont(ofSize: 175, weight: UIFontWeightThin)
        } else if characterCount == 4 {
            label.font = UIFont.systemFont(ofSize: 144, weight: UIFontWeightThin)
        } else if characterCount == 5 {
            label.font = UIFont.systemFont(ofSize: 115, weight: UIFontWeightThin)
        } else if characterCount == 6 {
            label.font = UIFont.systemFont(ofSize: 96, weight: UIFontWeightThin)
        } else if characterCount == 7 {
            label.font = UIFont.systemFont(ofSize: 82, weight: UIFontWeightThin)
        } else if characterCount == 8 {
            label.font = UIFont.systemFont(ofSize: 72, weight: UIFontWeightThin)
        } else if characterCount == 9 {
            label.font = UIFont.systemFont(ofSize: 64, weight: UIFontWeightThin)
        } else if characterCount == 10 {
            label.font = UIFont.systemFont(ofSize: 57, weight: UIFontWeightThin)
        }
    }
}
