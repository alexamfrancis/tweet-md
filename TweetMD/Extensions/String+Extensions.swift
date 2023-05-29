//
//  String+Extensions.swift
//  TweetMD
//
//  Created by Alexandra Francis on 1/20/21.
//  Copyright © 2021 Doximity. All rights reserved.
//

import UIKit

extension String {
    
    func getUserMentions() -> [UserMention] {
        let words = self.components(separatedBy: CharacterSet.whitespacesAndNewlines)
        var handles = words.filter({ $0.first == "@" })
        for i in 0..<handles.count {
            handles[i].removeAll{ $0 == ":" }
        }
        return handles.map{ UserMention($0) }
    }
    
    func getAttributedHandleString() -> NSAttributedString {
        var ranges = [NSRange]()
        var isHandle = false
        var location: Int = 0
        var length: Int = 0
        for i in 0..<self.count {
            let index = self.index(self.startIndex, offsetBy: i)
            if self[index] == "@" {
                location = i
                isHandle = true
            }
            if isHandle { length += 1 }
            if isHandle, (self[index] == " " || self[index] == ":" || self[index] == "." || self[index] == "," || self[index] == "#") {
                let range = NSRange(location: location, length: length - 1)
                ranges.append(range)
                isHandle = false
                length = 0
            }
        }
        let mutableAttributedString = NSMutableAttributedString.init(string: self)
        for range in ranges {
            mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.actionBlue, range: range)
        }
        return mutableAttributedString
    }
    
}
