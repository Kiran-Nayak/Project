//
//  PhoneNumberViewModel.swift
//  Project
//
//  Created by Kiran Nayak on 14/08/23.
//

import Foundation

class PhoneNumberViewModel {
    func phoneNumberResponse(mobileNo: String, repository: Repository) async throws -> PhoneNumberResponseModel {
        do {
            let data = try await repository.phoneNumberResponse(request: APIRequest(endpoint: .phoneNumber, httpMethod: .POST, requestBody: ["number": "\(mobileNo)"]))
            return data
        }catch {
            throw error
        }
    }
}
