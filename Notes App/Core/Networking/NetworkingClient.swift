//
//  NetworkingClient.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-07.
//

import Foundation
import Resolver

public class NetworkingClient {
    @Injected private var session: URLSession
    
    public func makeRequest<ResponseType: Decodable>(
        type: ResponseType.Type,
        withMethod method: APIHttpMethod,
        url: URL,
        body: [String : String]? = nil,
        queryParameters: [String : String]? = nil,
        headers: [String : String]? = nil) async throws -> ResponseType {
            
            guard let completeUrl = makeUrlComponents(withUrl: url, queryParameters: queryParameters)?.url else {
                throw APIErrors.invalidRequestWithIncorrectUrlFormat
            }
            
            let request = makeUrlRequest(withMethod: method,
                                         url: completeUrl,
                                         body: body,
                                         queryParameters: queryParameters,
                                         headers: headers)
            let response = try await data(for: request)
            return try parseResponse(type: type, response: response)
            
        }
    
    
    private func parseResponse<ResponseType: Decodable>(type: ResponseType.Type,
                                                         response: APIHttpResponse) throws -> ResponseType {
        print(response.debugString)
        switch response.statusCode {
        case 200..<300:
            return try response.data.converData(toType: type, dateDecodingStrategy: .iso8601)
        case 400:
            let result = try response.data.converData(toType: HttpMessageResponse.self, dateDecodingStrategy: .iso8601)
            throw APIErrors.badRequest(result.message)
        default:
            throw APIErrors.invalidResponse
        }
        
    }
    
    private func makeUrlComponents(withUrl url: URL, queryParameters: [String : String]? = nil) -> URLComponents? {
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        queryParameters?.forEach { urlComponents?.queryItems?.append(URLQueryItem(name: $0, value: $1)) }
        return urlComponents
        
    }
    
    private func makeUrlRequest(withMethod method: APIHttpMethod,
                                url: URL,
                                body: [String : String]? = nil,
                                queryParameters: [String : String]? = nil,
                                headers: [String : String]? = nil) -> URLRequest {
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if  (method == .POST || method == .PUT || method == .PATCH),
            let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        }
        return request
        
    }
    
    private func data(for request: URLRequest) async throws -> APIHttpResponse {
        
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIErrors.invalidResponse
        }
        return APIHttpResponse(data: data, response: httpResponse)
        
    }
    
}


public struct APIHttpResponse {
    let data: Data
    let response: HTTPURLResponse
    var statusCode: Int {
        return response.statusCode
    }
    
    var debugString: String {
        let result = String(data: data, encoding: .utf8)
        return "Status Code: \(statusCode) - \(result ?? "<some-wrong>"))"
    }
}

public enum APIHttpMethod: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}


public enum APIErrors: Error {
    case invalidResponse
    case invalidRequestWithIncorrectUrlFormat
    case badRequest(String)
    case invalidUrl
    case unauthorized
}
