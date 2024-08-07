// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public extension URLSession {
    /// Fetches the data and HTTP response from the specified URL.
        ///
        /// - Parameters:
        ///   - url: The URL from which to fetch data.
        /// - Returns: A tuple containing the data and the HTTPURLResponse.
    func getData(from url: URL) async throws -> (data: Data, response: HTTPURLResponse) {
        try await getRequestData(for: URLRequest(url: url))
    }
    
    /// Fetches the data and HTTP response for the specified URL request.
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
