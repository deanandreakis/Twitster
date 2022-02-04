//
//  Date+TimeAgo.swift
//  Twitter
//
//  Created by Dean Andreakis on 2/3/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import Foundation

extension Date {
        func timeAgoDisplay() -> String {
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .full
            return formatter.localizedString(for: self, relativeTo: Date())
        }
    }
