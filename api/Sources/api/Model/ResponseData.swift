//
//  ResponseData.swift
//  AmeriCount
//
//  Created by Vitor Otero on 09/08/2024.
//

import Foundation

public struct ResponseData<T>: Codable where T: Codable {
    public var data: [T]
}
