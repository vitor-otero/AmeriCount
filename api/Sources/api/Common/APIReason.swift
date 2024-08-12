//
//  APIReason.swift
//  AmeriCount
//
//  Created by Vitor Otero on 09/08/2024.
//

import Foundation

public struct APIReason: Codable {
    public let error: Bool
    public let reason: String
}

public class APIError: Codable {
    public let errorCode: Int
    public let reason: APIReason

    public init(errorCode: String, reason: APIReason) {
        self.errorCode = Int(errorCode) ?? 0
        self.reason = reason
    }
}
