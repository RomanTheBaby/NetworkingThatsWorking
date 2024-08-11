//
//  PlanetsResponse.swift
//  NetworkingThatsWorking
//
//  Created by Roman on 2024-09-07.
//

import Foundation


struct PlanetsRequest: NetworkRequest {
    typealias Model = PlanetsReponse
    
    var baseURL: URL {
        .swapi
    }
    
    var path: String {
        "/api/planets"
    }
    
    var queryItems: [String: String]? {
        ["page": "1"]
    }
    
}
