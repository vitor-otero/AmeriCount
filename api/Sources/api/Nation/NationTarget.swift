//
//  NationTarget.swift
//  AmeriCount
//
//  Created by Vitor Otero on 11/08/2024.
//

import Foundation

public protocol NationRequestable {
    func getNationData() async throws -> ResponseData<PopulationDto>?
    func getStateData() async throws -> ResponseData<StatePopulationDto>?
}

public enum NationTarget {
    case getNationData
    case getStateData
}

extension NationTarget: TargetEndpoint {
    public var queryString: [URLQueryItem] {
        switch self {
        case .getNationData:
            return [
                URLQueryItem(name: "drilldowns", value: "Nation"),
                URLQueryItem(name: "measures", value: "Population")
            ]
        case .getStateData:
            return [
                URLQueryItem(name: "drilldowns", value: "State"),
                URLQueryItem(name: "measures", value: "Population"),
                URLQueryItem(name: "year", value: "2020"),
            ]
        }
    }
    
    // TODO: Value should be in the config schema
    public var baseURL: URL {
        return URL(string: "https://datausa.io/api/")!
    }
    
    public var path: String {
        "data"
    }
    
    public var method: HttpMethodEnum {
        switch self {
        case .getNationData:
            return .get
        case.getStateData:
            return .get
        }
    }

    public var headers: [String : String]? {
        return nil
    }
}
