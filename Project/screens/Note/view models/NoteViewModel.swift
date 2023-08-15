//
//  NoteViewModel.swift
//  Project
//
//  Created by Kiran Nayak on 15/08/23.
//

import Foundation

class NoteViewModel {
    func getNotes(repository: Repository) async throws -> NoteResponseModel {
        do {
            let data = try await repository.noteResponse(request: APIRequest(endpoint: .note, httpMethod: .GET, requestBody: nil))
            return data
        }catch {
            throw error
        }
    }
}
