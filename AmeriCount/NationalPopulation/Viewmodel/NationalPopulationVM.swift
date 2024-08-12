//
//  NationalPopulationVM.swift
//  AmeriCount
//
//  Created by Vitor Otero on 09/08/2024.
//

import Foundation
import api
import Combine

class NationalPopulationVM: ObservableObject {
    @Published public var nationPopulationData: [PopulationDto] = []

    private let networkService: NationRequestable = NationManagerAPI()

    func fetchNationPopulation() async throws {
        let response: ResponseData<PopulationDto>? = try await networkService.getNationData()
        DispatchQueue.main.async {
            self.nationPopulationData = response?.data ?? []
        }
    }
}
