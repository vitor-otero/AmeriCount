//
//  StatePopulationVM.swift
//  AmeriCount
//
//  Created by Vitor Otero on 09/08/2024.
//

import Foundation
import api
import Combine

class StatePopulationVM: ObservableObject {
    @Published public var statePopulationData: [StatePopulationDto] = []

    private let manager = NationManagerAPI()

    func fetchStatePopulation() async {
        do {
            let response: ResponseData<StatePopulationDto>? = try await manager.getStateData()
            DispatchQueue.main.async {
                self.statePopulationData = response?.data ?? []
            }
        } catch {
            print("Failed to fetch state population data: \(error)")
        }
    }
}
