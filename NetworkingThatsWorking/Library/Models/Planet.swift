//
//  Planet.swift
//  NetworkingThatsWorking
//
//  Created by Roman on 2024-09-07.
//

import Foundation

struct Planet: Codable {
    var name: String
    var population: String
    var terrain: String
    var climate: String
}

struct PlanetsReponse: Codable {
    var count: Int
    var planets: [Planet]
    
    enum CodingKeys: String, CodingKey {
        case count
        case planets = "results"
    }
}
