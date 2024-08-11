//
//  NetworkService.swift
//  NetworkingThatsWorking
//
//  Created by Roman on 2024-09-07.
//

import Foundation


class NetworkService {
    
    enum ServiceError: Error {
        case failedToCreateRequest
        case invalidResponse
    }
    
    private let decoder = JSONDecoder()
    
    func make<Request: NetworkRequest>(request: Request) async throws -> Request.Model {
        guard let urlRequest = request.urlRequest else {
            throw ServiceError.failedToCreateRequest
        }
        
        print("Request for ", urlRequest)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ServiceError.invalidResponse
        }
        
        return try decoder.decode(Request.Model.self, from: data)
    }
    
}

private extension NetworkRequest {
    var urlRequest: URLRequest? {
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        urlComponents.path = path
        urlComponents.queryItems = queryItems?.map({ (key: String, value: String) -> URLQueryItem in
            URLQueryItem(name: key, value: value)
        })
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        if let body {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        return urlRequest
    }
}
