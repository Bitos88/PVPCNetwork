// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public extension URLSession {
    func getData(from url: URL) async throws -> (data: Data, response: HTTPURLResponse) {
        try await getRequestData(for: URLRequest(url: url))
    }
    
    func getRequestData(for request: URLRequest) async throws -> (data: Data, response: HTTPURLResponse) {
        do {
            let (data, response) = try await data(for: request)
            
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.nonHTTP
            }
            return (data, response)
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.general(error)
        }
    }
}
