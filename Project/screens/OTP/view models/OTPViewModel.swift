//
//  OTPViewModel.swift
//  Project
//
//  Created by Kiran Nayak on 15/08/23.
//

import Foundation

class OTPViewModel {
    func otpResponse(mobileNo: String, otp: String, repository: Repository) async throws -> OTPResponseModel {
        do {
            let data = try await repository.otpResponse(request: APIRequest(endpoint: .otp, httpMethod: .POST, requestBody: ["number": "\(mobileNo)", "otp": otp]))
            return data
        }catch {
            throw error
        }
    }
}
