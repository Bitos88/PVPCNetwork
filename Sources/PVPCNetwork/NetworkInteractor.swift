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
    
    
    /// Obtain a generic type of data that conforms with the Codable protocol. For example, a JSON.
    ///
    /// - Parameters:
    ///   - request: The URLRequest to perform the async call.
    ///   - type: The type of the data expected to be decoded from the JSON response.
    ///   - decoder: The JSONDecoder used to decode the JSON data. Default is `JSONDecoder()`.
    ///
    ///>Important: You can change the date decode strategy setting on decoder.
    ///
    ///
    /// - Returns: A decoded instance of the specified type.
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
