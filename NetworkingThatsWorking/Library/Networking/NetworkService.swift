//
//  NetworkService.swift
//  NetworkingThatsWorking
//
//  Created by Roman on 2024-08-10.
//

import Foundation

class NetworkService {
    
    private let urlSession: URLSession
    private let decoder = JSONDecoder()
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func makeRequest<Request: NetworkRequest>(_ request: Request) async throws -> Request.Model {
        guard let urlRequest = request.urlRequest else {
            throw NSError(
                domain: "com.my_app.NetworkService",
                code: URLError.Code.badServerResponse.rawValue,
                userInfo: [
                    NSLocalizedFailureErrorKey: "Failed to build network request"
                ]
            )
        }
        
        print("Making request for url: ", urlRequest.url?.absoluteString ?? "No URL")
        
        let (data, response) = try await urlSession.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NSError(
                domain: "com.my_app.NetworkService",
                code: URLError.Code.badServerResponse.rawValue,
                userInfo: [
                    NSLocalizedDescriptionKey: "Failed to handle network response",
                    NSLocalizedFailureErrorKey: "Response is not of type HTTPURLResponse"
                ]
            )
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NSError(
                domain: "com.my_app.NetworkService",
                code: httpResponse.statusCode,
                userInfo: [NSLocalizedDescriptionKey: "Invalid response code: \(httpResponse.statusCode)"]
            )
        }
        
        return try decoder.decode(Request.Model.self, from: data)
    }
}

private extension NetworkRequest {
    var urlRequest: URLRequest? {
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        components.path = path
        if queryItems.isEmpty == false {
            components.queryItems = queryItems.map { URLQueryItem(name: $0, value: $1) }
        }
        
        guard let url = components.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if body.isEmpty == false {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        return request
    }
}
