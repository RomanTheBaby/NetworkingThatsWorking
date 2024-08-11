//
//  PlanetsFetchingService.swift
//  NetworkingThatsWorking
//
//  Created by Roman on 2024-08-10.
//

import Foundation

class PlanetsFetchingService {
    
    private let networkService = NetworkService()
    
    func fetchPlanets() async throws -> [Planet] {
        let planetsRequest = PlanetsRequest()
        let planetsResponse = try await networkService.make(request: planetsRequest)
        return planetsResponse.planets
    }
    
    func fetchPlanet(at index: Int) async throws -> Planet {
        let planetRequest = PlanetInformationRequest(planetIndex: index)
        return try await networkService.make(request: planetRequest)
    }
    
}
