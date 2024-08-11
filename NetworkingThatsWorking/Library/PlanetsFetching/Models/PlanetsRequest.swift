//
//  PlanetsRequest.swift
//  NetworkingThatsWorking
//
//  Created by Roman on 2024-08-10.
//

import Foundation

// MARK: - Request

struct PlanetsRequest: NetworkRequest {
    typealias Model = PlanetsPage
    
    var baseURL: URL = .swapi
    var path: String = "/api/planets"
    var headers = ["Content-Type": "application/json"]
    
}

// MARK: - PlanetsPage

struct PlanetsPage: Codable {
    var count: Int
    var results: [Planet]
}
