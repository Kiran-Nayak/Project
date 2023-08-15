//
//  Repository.swift
//  Project
//
//  Created by Kiran Nayak on 14/08/23.
//

import Foundation

/// This is a protocol which will impletemet in IMPL Class
/// This Protocol provides basic functions to communicate with viewmodel
protocol Repository {
    func phoneNumberResponse(request: APIRequest) async throws -> PhoneNumberResponseModel
    func otpResponse(request: APIRequest) async throws -> OTPResponseModel
    func noteResponse(request: APIRequest) async throws -> NoteResponseModel
}
