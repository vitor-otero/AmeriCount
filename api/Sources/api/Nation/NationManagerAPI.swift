//
//  NationManagerAPI.swift
//  AmeriCount
//
//  Created by Vitor Otero on 11/08/2024.
//

import Foundation

public class NationManagerAPI: NationRequestable {
    public init() {
        
    }
    
    public func getNationData() async throws -> ResponseData<PopulationDto>? {
        let target = NationTarget.getNationData
        return try await BaseNetworkWorker<ResponseData<PopulationDto>, APIError>(target: target).urlRequest()
    }
    
    public func getStateData() async throws -> ResponseData<StatePopulationDto>? {
        let target = NationTarget.getStateData
        return try await BaseNetworkWorker<ResponseData<StatePopulationDto>, APIError>(target: target).urlRequest()
    }
}
