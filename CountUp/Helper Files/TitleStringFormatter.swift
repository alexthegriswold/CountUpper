//
//  TitleStringFormatter.swift
//  CountUp
//
//  Created by Alexander Griswold on 8/24/18.
//  Copyright © 2018 com.example. All rights reserved.
//

import Foundation

class TitleStringFormatter {
    func formatString(for timeDelta: TimeDeltaButtonType, with timeDifference: TimeDifferenceType) -> String {
        let pastOrFutureString = timeDifference == .past ? "Since" : "Until"
        return "\(timeDelta.rawValue) \(pastOrFutureString)"
    }
}
