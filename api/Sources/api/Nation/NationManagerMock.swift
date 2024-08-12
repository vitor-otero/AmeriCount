//
//  NationManagerMock.swift
//  AmeriCount
//
//  Created by Vitor Otero on 11/08/2024.
//

import Foundation

public class NationManagerMock: NationRequestable {
    public init() {
        
    }
    public func getNationData() async throws -> ResponseData<PopulationDto>? {
        throw NetworkError.notFound
    }
    
    public func getStateData() async throws -> ResponseData<StatePopulationDto>? {
        throw NetworkError.authenticationError
    }
}
