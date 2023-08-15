//
//  APIEndpoint.swift
//  Project
//
//  Created by Kiran Nayak on 14/08/23.
//

import Foundation


/// This is used to get endpoints of an API
enum APIEndpoints : String {
    case phoneNumber = "/users/phone_number_login"
    case otp = "/users/verify_otp"
    case note = "/users/test_profile_list"
    case none = ""
}
