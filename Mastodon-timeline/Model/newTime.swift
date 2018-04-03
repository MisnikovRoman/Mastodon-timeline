//
//  NewTime.swift
//  Mastodon-timeline
//
//  Created by Роман Мисников on 03.04.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation

struct NewTime {
    var seconds: Int = 0
    var minutes: Int = 0
    var hours: Int = 0
    var days: Int = 0
    
    init(seconds: Int) {
        
        let minutes = seconds / 60
        let hours = minutes / 60
        let days = hours / 24
        
        self.seconds = seconds
        self.minutes = minutes
        self.hours = hours
        self.days = days
        
    }
    
    func printTime() -> String {
        
        if (seconds < 60) { return "\(seconds) seconds ago" }
        else if (minutes < 60) { return "\(minutes) minutes ago" }
        else if (hours < 24) { return "\(hours) hours ago" }
        else {return "\(days) days ago"}
    }
}
