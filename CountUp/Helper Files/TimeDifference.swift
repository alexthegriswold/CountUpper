//
//  TimeDifferences.swift
//  CountUp
//
//  Created by Alexander Griswold on 8/24/18.
//  Copyright © 2018 com.example. All rights reserved.
//

import Foundation

struct TimeDifference {
    let value: UInt64
    let timeDifferenceType: TimeDifferenceType
    
    init(value: UInt64, timeDifferenceType: TimeDifferenceType) {
        self.value = value
        self.timeDifferenceType = timeDifferenceType
    }
}

enum TimeDifferenceType {
    case past, future
}
