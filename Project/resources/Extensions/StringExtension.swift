//
//  StringExtension.swift
//  Project
//
//  Created by Kiran Nayak on 14/08/23.
//

import Foundation

extension String {
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && self.count == 10
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}
