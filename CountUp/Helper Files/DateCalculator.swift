//
//  DateCalculator.swift
//  CountUp
//
//  Created by Alexander Griswold on 8/24/18.
//  Copyright © 2018 com.example. All rights reserved.
//

import Foundation

class DateCalculator {
    func getTimeDifferences(for timeDelta: TimeDeltaButtonType, currentDate: Date, compareDate: Date) -> TimeDifference {
        let calendar = Calendar.current
        
        guard let newCompareDate = formatCompareDate(compareDate: compareDate, currentDate: currentDate) else {
            return TimeDifference(value: 0, timeDifferenceType: .past)
        }
        
        if timeDelta != .second {
            
            var timeDifference: Int?
            
            switch timeDelta {
            case .day:
                timeDifference = calendar.dateComponents([.day], from: newCompareDate, to: currentDate).day
            case .hour:
                timeDifference = calendar.dateComponents([.hour], from: newCompareDate, to: currentDate).hour
            case .minute:
                timeDifference = calendar.dateComponents([.minute], from: newCompareDate, to: currentDate).minute
            case .second:
                break
            }
            
            guard let unwrappedTimeDifference = timeDifference else { fatalError() }
            
            if unwrappedTimeDifference < 0 {
                let timeValue = unwrappedTimeDifference * -1
                return TimeDifference(value: UInt64(timeValue), timeDifferenceType: .future)
            } else {
                return TimeDifference(value: UInt64(unwrappedTimeDifference), timeDifferenceType: .past)
            }
            
        } else {
            guard let minutes = calendar.dateComponents([.minute], from: newCompareDate, to: currentDate).minute else { fatalError() }
            guard var years = calendar.dateComponents([.year], from: newCompareDate, to: currentDate).year else { fatalError() }
            
            let timeDifferenceType: TimeDifferenceType = minutes < 0 ? .future : .past
            years = years < 0 ? (years * -1) : years
            
            
            let fiftyYearsInSeconds = 1577923200
            let remainder = years % 50
            let fiftyYearUnits = ((years - remainder)/50)
            let nonRemainderSeconds = UInt64(fiftyYearUnits * fiftyYearsInSeconds)
            
            var totalSeconds: UInt64 = 0
            
            if timeDifferenceType == .future {
                guard let newDate = calendar.date(byAdding: .year , value: -fiftyYearUnits * 50, to: newCompareDate) else { fatalError() }
                guard let remainderSeconds = calendar.dateComponents([.second], from: currentDate, to: newDate).second else { fatalError() }
                totalSeconds = nonRemainderSeconds + UInt64(remainderSeconds)
            } else {
                guard let newDate = calendar.date(byAdding: .year , value: fiftyYearUnits * 50, to: newCompareDate) else { fatalError() }
                guard let remainderSeconds = calendar.dateComponents([.second], from: newDate, to: currentDate).second else { fatalError() }
                totalSeconds = nonRemainderSeconds + UInt64(remainderSeconds)
            }
            
            return TimeDifference(value: totalSeconds, timeDifferenceType: timeDifferenceType)
        }
    }
    
    //formats to the beginning or end of the compare date depnding if it is in the futurue or past
    //returns nil if the compare date is today
    func formatCompareDate(compareDate: Date, currentDate: Date) -> Date? {
        let calendar = Calendar.current
        
        //by setting hour doesn't work on old dates
        if calendar.isDateInToday(compareDate) {
            return nil
        } else if compareDate < currentDate {
            //going into the past means we'll get the end of the compare date
            guard let nextDay = calendar.date(byAdding: .day , value: 1, to: compareDate) else { fatalError() }
            if let endOfCompareDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: nextDay) {
                return endOfCompareDate
            } else {
                return compareDate
            }
        } else {
            //this is if we're going into the future
            guard let beginningOfCompareDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: compareDate) else { fatalError() }
            return beginningOfCompareDate
        }
    }
}
