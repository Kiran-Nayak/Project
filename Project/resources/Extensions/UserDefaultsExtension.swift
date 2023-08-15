//
//  UserDefaultsExtension.swift
//  Project
//
//  Created by Kiran Nayak on 14/08/23.
//

import Foundation

extension UserDefaults {
    // MARK: - Keys
    private struct Keys {
        static let auth_token = "auth_token"
    }

    // MARK: - Getter / Setter
    static var authKey: String {
        get {
            return UserDefaults.standard.string(forKey: UserDefaults.Keys.auth_token) ?? ""
        }
        set(value) {
            UserDefaults.standard.setValue(value, forKey: UserDefaults.Keys.auth_token)
        }
    }
}
