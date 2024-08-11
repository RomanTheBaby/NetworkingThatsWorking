//
//  PlanetInformationRequest.swift
//  NetworkingThatsWorking
//
//  Created by Roman on 2024-08-10.
//

import Foundation

struct PlanetInformationRequest: NetworkRequest {
    typealias Model = Planet
    
    var planetIndex: Int
    
    var baseURL: URL {
        .swapi
    }
    
    var path: String {
        "/api/planets/\(planetIndex)"
    }
}
