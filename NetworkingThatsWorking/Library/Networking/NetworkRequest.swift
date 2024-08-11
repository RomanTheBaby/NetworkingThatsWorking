//
//  NetworkRequest.swift
//  NetworkingThatsWorking
//
//  Created by Roman on 2024-09-07.
//

import Foundation

protocol NetworkRequest {
    associatedtype Model: Codable
    
    var baseURL: URL { get }
    var path: String { get }
    var body: [String: Any]? { get }
    var queryItems: [String: String]? { get }
    var headers: [String: String]? { get }
    var method: RequestMethod { get }
}

extension NetworkRequest {
    var body: [String: Any]? {
        nil
    }
    
    var queryItems: [String: String]? {
        nil
    }
    
    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
    
    var method: RequestMethod {
        .get
    }
}
