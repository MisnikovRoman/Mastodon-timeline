//
//  Mastodon_timelineTests.swift
//  Mastodon-timelineTests
//
//  Created by Роман Мисников on 03.04.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import XCTest
@testable import Mastodon_timeline

class Mastodon_timelineTests: XCTestCase {
    
    func testTimeSincePost() {
        let sec: Int = 3000
        let time = NewTime(seconds: sec)
        let output = time.printTime()
        
        XCTAssertEqual(output, "50 minutes ago")
        XCTAssertEqual(NewTime(seconds: 1231102).printTime(), "14 days ago")
    }
    
}
