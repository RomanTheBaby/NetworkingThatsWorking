//
//  PlanetsFetchingService.swift
//  NetworkingThatsWorking
//
//  Created by Roman on 2024-08-10.
//

import Foundation

class PlanetsFetchingService {
    
    let networkService = NetworkService()
    
    func fetchPlanets() async throws -> [Planet] {
        let planetsPage = try await networkService.makeRequest(PlanetsRequest())
        return planetsPage.results
    }
    
    func fetchPlanet(at index: Int) async throws -> Planet {
        try await networkService.makeRequest(PlanetInformationRequest(planetIndex: index))
    }
    
}
