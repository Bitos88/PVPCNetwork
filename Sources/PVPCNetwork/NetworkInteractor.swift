//
//  File.swift
//  
//
//  Created by Alberto Alegre Bravo on 7/8/24.
//

import Foundation

public protocol NetworkInteractorProtocol {
    var session: URLSession { get }
}

public extension NetworkInteractorProtocol {
    var session: URLSession { .shared }
    
    func getJSON<JSON>(request: URLRequest, type: JSON.Type, decoder: JSONDecoder = JSONDecoder()) async throws -> JSON where JSON: Codable {
        let (data, response) = try await session.getRequestData(for: request)
        
        if response.statusCode == 200 {
            do {
                return try decoder.decode(type, from: data)
            } catch {
                throw NetworkError.json(error)
            }
        } else {
            throw NetworkError.status(response.statusCode)
        }
    }
}
