//
//  APIService.swift
//  Project
//
//  Created by Kiran Nayak on 14/08/23.
//

import Foundation

/// Primary API Service
final class APIService {
    
    /// Uses to make it Singleton instance
    public static var shared = APIService()
    
    /// Private instance
    private init() {}
    
    /// Used to make API Calls
    /// - Parameters:
    ///   - request: Request instance
    ///   - type: Expected Response type
    ///   - completion: callback with success or error
    ///   - api: Type of API
    public func execute<T: Codable>(
        _ req: APIRequest,
        responseType type: T.Type,
        apiType api: APITypes
    ) async throws -> T {
        guard let req = request(req, api) else {
            throw APIError.failedToCreateRequest
        }
        do {
            let (data, response) = try await URLSession.shared.data(for: req)
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
                /// Authentication Failed
                if (response as? HTTPURLResponse)?.statusCode == 401 {
                    UserDefaults.authKey = ""
                }
                throw APIError.nonSuccessCode
            }
            return try JSONDecoder().decode(type.self, from: data)
        }catch {
            dump(error)
            throw error
        }
    }
    
    /// Construct request
    /// - Parameters:
    ///   - request: request parameters
    ///   - api: type of api
    /// - Returns: URLRequest instance
    private func request(_ request: APIRequest, _ api: APITypes) -> URLRequest? {
        guard let url = request.url else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        if request.requestBody != nil {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: request.requestBody ?? [:])
        }
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.timeoutInterval = 50
        switch api {
        case .secure:
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue(UserDefaults.authKey, forHTTPHeaderField: "Authorization")
        case .none:
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            break
        }
        
        return urlRequest
    }
}

/// Perticular API Types
enum APITypes {
    case secure
    case none
}

/// API Errors
enum APIError: Error {
    case failedToCreateRequest
    case nonSuccessCode
    case unableToDecode
}
