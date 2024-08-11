//
//  File.swift
//  
//
//  Created by Javier Duvan Hospital Melo on 10/08/24.
//

import Foundation

public struct CustomError: Error, LocalizedError, Decodable {
    let code: String
    let message: String

    public var errorDescription: String? {
        return "\(code): \(message)"
    }
}

enum HTTPStatusCodeCategory {
    case success
    case clientError
    case serverError
    case other

    init(statusCode: Int) {
        switch statusCode {
        case 200..<300:
            self = .success
        case 400..<500:
            self = .clientError
        case 500..<600:
            self = .serverError
        default:
            self = .other
        }
    }
}

extension HTTPURLResponse {
    var statusCodeCategory: HTTPStatusCodeCategory {
        return HTTPStatusCodeCategory(statusCode: statusCode)
    }
}

enum ApiCustomError: Swift.Error {
    case invalidData
    case badRequest(message: String, code: String)
    case serverError(message: String, code: String)
}
