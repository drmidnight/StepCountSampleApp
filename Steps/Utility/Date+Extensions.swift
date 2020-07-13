//
//  Date+Extensions.swift
//  Steps
//
//  Created by Corey Morello on 7/13/20.
//  Copyright © 2020 Corey Morello. All rights reserved.
//

import Foundation

extension Date {
    public var shortDateString: String? {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: self)
    }

    public var daysAgoString: String? {
        guard let diffInDays = Calendar.current.dateComponents([.day], from: self, to: Date()).day else { return nil }

        // TODO: break this out and add Month ago, year ago etc
        if diffInDays == 0 {
            return "Today"
        }

        if diffInDays == 1 {
            return "Yesterday"
        }

        return "\(diffInDays) days ago"
    }

}
