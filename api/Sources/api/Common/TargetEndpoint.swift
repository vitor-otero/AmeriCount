//
//  TargetEndpoint.swift
//  AmeriCount
//
//  Created by Vitor Otero on 09/08/2024.
//

import Foundation


public protocol TargetEndpoint {

    /// The target's base `URL`.
    var baseURL: URL { get }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }

    /// The HTTP method used in the request.
    var method: HttpMethodEnum { get }

    /// The headers to be used in the request.
    var headers: [String : String]? { get }
    
    var queryString: [URLQueryItem] { get }
}
