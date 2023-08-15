//
//  OnOTPDelegate.swift
//  Project
//
//  Created by Kiran Nayak on 15/08/23.
//

import Foundation

/// Delegate used to notify viewcontroller once otp got verified
protocol OnOTPDelegate: AnyObject {
    func onSuccess()
}
