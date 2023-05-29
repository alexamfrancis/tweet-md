//
//  TweetMDTests.swift
//  TweetMDTests
//
//  Created by Kimberly Hsiao on 1/11/19.
//  Copyright © 2019 Doximity. All rights reserved.
//  Documentation on Quick/Nimble: https://github.com/Quick/Nimble
//

import Foundation
import Quick
import Nimble

@testable import TweetMD

class TweetMDTests: QuickSpec {
    
    override func spec() {
        
        it("passes this test") {
            expect(true).to(beTrue())
        }
        
        it("passes this math test") {
            expect(1+1).to(equal(2))
        }
        
        it("passes date test: just now") {
            let timeElapseString = Date.timeElapsedString(since: Date())
            expect(timeElapseString).to(equal("just now"))
        }
        
        it("passes date test: minutes") {
            let timeElapseString = Date.timeElapsedString(since: Date(timeIntervalSinceNow: TimeInterval(-120)))
            expect(timeElapseString).to(equal("2m"))
        }
        
        it("passes date test: hours") {
            let timeElapseString = Date.timeElapsedString(since: Date(timeIntervalSinceNow: TimeInterval(-14400)))
            expect(timeElapseString).to(equal("4h"))
        }
        
        it("passes date test: days") {
            let timeElapseString = Date.timeElapsedString(since: Date(timeIntervalSinceNow: TimeInterval(-432000)))
            expect(timeElapseString).to(equal("5d"))
        }
        it("passes date test: days") {
            let date = Date(timeIntervalSinceReferenceDate: TimeInterval(432000))
            let timeElapseString = Date.timeElapsedString(since: date)
            expect(timeElapseString).to(equal("1/5/01"))
        }

    }
}
