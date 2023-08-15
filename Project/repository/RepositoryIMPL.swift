//
//  Repository.swift
//  Project
//
//  Created by Kiran Nayak on 14/08/23.
//

import Foundation

/// It is implementation of Repository
class RepositoryIMPL: Repository {
    func noteResponse(request: APIRequest) async throws -> NoteResponseModel {
        do {
            let data = try await APIService.shared.execute(request, responseType: NoteResponseModel.self, apiType: .secure)
            return data
        }
        catch {
            throw error
        }
    }
    
    func phoneNumberResponse(request: APIRequest) async throws -> PhoneNumberResponseModel {
        do {
            let data = try await APIService.shared.execute(request, responseType: PhoneNumberResponseModel.self, apiType: .none)
            return data
        }
        catch {
            throw error
        }
    }
    
    func otpResponse(request: APIRequest) async throws -> OTPResponseModel {
        do {
            let data = try await APIService.shared.execute(request, responseType: OTPResponseModel.self, apiType: .none)
            return data
        }
        catch {
            throw error
        }
    }
    
}
