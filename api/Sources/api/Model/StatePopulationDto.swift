//
//  StatePopulationModel.swift
//  AmeriCount
//
//  Created by Vitor Otero on 09/08/2024.
//

import Foundation

public struct StatePopulationDto: Codable {
   public let idState: String?
   public let state: String?
   public let idYear: Int?
   public let year: String?
   public let population: Int?
   public let slugState: String?

    enum CodingKeys: String, CodingKey {
        case idState = "ID State"
        case state = "State"
        case idYear = "ID Year"
        case year = "Year"
        case population = "Population"
        case slugState = "Slug State"
    }
}
