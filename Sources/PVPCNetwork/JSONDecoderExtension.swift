//
//  File.swift
//  
//
//  Created by Alberto Alegre Bravo on 7/8/24.
//

import Foundation

public extension JSONDecoder {
    static let isoDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    static let customDateDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
}
