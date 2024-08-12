//
//  NetworkError.swift
//  AmeriCount
//
//  Created by Vitor Otero on 09/08/2024.
//

import Foundation

public enum NetworkError: Error, Equatable, Comparable {
    public static func < (lhs: NetworkError, rhs: NetworkError) -> Bool {
        lhs.localizedDescription < rhs.localizedDescription
    }
    
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        lhs.localizedDescription == rhs.localizedDescription
    }

    case notFound
    case invalidResponse
    case authenticationError
    case serverError(error: Codable)
}

extension NetworkError {
    public var localizedDescription: String {
        switch self {
        case .notFound:
            return "The requested resource could not be found."
        case .invalidResponse:
            return "The server responded with invalid data."
        case .authenticationError:
            return "Authentication failed. Please check your credentials."
        default:
            return "An unknown error occurred. Please try again later."
        }
    }
}
