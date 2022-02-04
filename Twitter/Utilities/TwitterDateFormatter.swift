//
//  TwitterDateFormatter.swift
//  Twitter
//
//  Created by Dean Andreakis on 2/4/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import Foundation

//"Fri Feb 04 15:33:51 +0000 2022" example string from twitter for created_on

func twitterDateFormatter(_ dateString:String)->Date {
    var retVal = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
    if let date = dateFormatter.date(from: dateString) {
      retVal = date
    }
    return retVal
}
