//
//  NetworkRequest.swift
//  NetworkingThatsWorking
//
//  Created by Roman on 2024-08-10.
//

import Foundation

protocol NetworkRequest {
    associatedtype Model: Codable
    var baseURL: URL { get }
    var path: String { get }
    var body: [String: Any] { get }
    var queryItems: [String: String] { get }
    var headers: [String: String] { get }
    var method: RequestMethod { get }
}

extension NetworkRequest {
    var body: [String: Any] {
        [:]
    }
    
    var queryItems: [String: String] {
        [:]
    }
    
    var headers: [String: String] {
        [:]
    }
    
    var method: RequestMethod {
        .get
    }
}
