//
//  BaseNetworkWorker.swift
//  AmeriCount
//
//  Created by Vitor Otero on 09/08/2024.
//

import Foundation
import OSLog

public class BaseNetworkWorker<T, E> where T: Codable, E: Codable {
    private var targetType: TargetEndpoint
    private let validStatusCode: [Int] = [200, 201]
    private let invalidStatusCode: [Int] = [401, 404]
    
    public init(target: TargetEndpoint) {
        self.targetType = target
    }
    
    private var finalUrl: URL {
        get {
            var components = URLComponents(url: targetType.baseURL, resolvingAgainstBaseURL: true)
            print(targetType)
            if targetType.queryString.count > 0 {
                components?.queryItems = targetType.queryString
            }
            guard let url = components?.url else {
                preconditionFailure("Invalid URL components")
            }
            let finalUrl: URL = url.appendingPathComponent(targetType.path)
            return finalUrl
        }
    }
    
    private var method: String {
        get {
            targetType.method.rawValue
        }
    }
    
    private var fixedHeaders: [String: String] {
        ["Content-Type": "application/json",
         "cache-control": "no-cache"]
    }
    
    private var headers: [String: String] {
        get {
            guard var headers = targetType.headers else { return fixedHeaders }
            for item in fixedHeaders {
                headers[item.key] = item.value
            }
            return headers
        }
    }
    
    public func urlRequest(contentBody: T? = nil) async throws -> T? {
        // Decoder
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        // set route with base and path
        var urlRequest = URLRequest(url: finalUrl)
        
        // set headers
        headers.forEach { (key, value) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        // http method
        urlRequest.httpMethod = method
        
        // http body
        if let httpBody = contentBody {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            let bodyData = try? jsonEncoder.encode(httpBody)
            urlRequest.httpBody = bodyData
        }

        Logger.apiLog.debug("API: \(urlRequest)")

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            Logger.apiLog.critical("API: \(NetworkError.invalidResponse.localizedDescription)")
            throw NetworkError.invalidResponse
        }

        guard !invalidStatusCode.contains(httpResponse.statusCode) else {
            switch httpResponse.statusCode {
            case 401:
                Logger.apiLog.warning("API: \(NetworkError.authenticationError)")
                throw NetworkError.authenticationError
            case 404:
                Logger.apiLog.error("API: \(NetworkError.notFound)")
                throw NetworkError.notFound
            default:
                let error: E = try decoder.decode(E.self, from: data)
                Logger.apiLog.critical("API: \(NetworkError.serverError(error: error))")
                throw NetworkError.serverError(error: error)
            }
        }

        guard validStatusCode.contains(httpResponse.statusCode) else {
            let error: E = try decoder.decode(E.self, from: data)
            Logger.apiLog.critical("API: \(NetworkError.serverError(error: error))")
            throw NetworkError.serverError(error: error)
        }

        return try decoder.decode(T?.self, from: data)
    }
}

public extension Logger {
    static let apiLog = Logger(subsystem: "org.v0t.AmeriCount", category: "API Client")
}
