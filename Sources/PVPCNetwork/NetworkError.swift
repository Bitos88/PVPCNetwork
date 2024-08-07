//
//  File.swift
//  
//
//  Created by Alberto Alegre Bravo on 7/8/24.
//

import Foundation

public enum NetworkError: LocalizedError {
    case general(Error)
    case status(Int)
    case json(Error)
    case dataNotValid
    case nonHTTP
    
    public var errorDescription: String? {
        switch self {
            case .general(let error):
                "General error: \(error.localizedDescription)."
            case .status(let int):
                "Status error. StatusCode: \(int)."
            case .json(let error):
                "JSON Error: \(error)."
            case .dataNotValid:
                "Data not valid."
            case .nonHTTP:
                "Not an HTTP connection."
        }
    }
}
