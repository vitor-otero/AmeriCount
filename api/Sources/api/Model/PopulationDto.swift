//
//  PopulationDto.swift
//  AmeriCount
//
//  Created by Vitor Otero on 09/08/2024.
//

import Foundation

public struct PopulationDto: Codable {
    public let idNation: String?
    public let nation: String?
    public let idYear: Int?
    public let year: String?
    public let population: Int?
    public let slugNation: String?

    enum CodingKeys: String, CodingKey {
        case idNation = "ID Nation"
        case nation = "Nation"
        case idYear = "ID Year"
        case year = "Year"
        case population = "Population"
        case slugNation = "Slug Nation"
    }
}
