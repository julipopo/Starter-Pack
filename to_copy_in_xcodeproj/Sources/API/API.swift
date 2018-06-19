//
//  API+Utils.swift
//  init_project
//
//  Created by julien on 18/06/2018.
//  Copyright © 2018 juliensimmer. All rights reserved.
//

import Foundation

typealias HTTPParameters = [String: String]
typealias HTTPBody = [String: Any]

public struct API {
    private static func isHttpFailureCode(_ code: Int) -> Bool {
        return code >= 400
    }
    
    static func request<T: Decodable>(root: String,
                                      method: HTTPMethod,
                                      parameters: HTTPParameters? = nil,
                                      body: HTTPBody? = nil,
                                      model: T.Type,
                                      success: @escaping (T) -> Void, failure: @escaping (APIError) -> Void) {
        
        guard let url = URL(string: root)?.withQueries(parameters) else {
            failure(.invalidURL)
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
    
            if error != nil {
                print(error?.localizedDescription ?? "")
                failure(.urlDomain)
                return
            }
            
            if let httpResponse = urlResponse as? HTTPURLResponse {
                if isHttpFailureCode(httpResponse.statusCode) {
                    failure(.other(message: ErrorFromServer.decode(from: data)))
                    return
                }
            }
            
            if let objectParsed = T.decode(from: data) {
                success(objectParsed)
                return
            } else {
                failure(.invalidJSON)
                return
            }
        }
        
        task.resume()
    }
}

struct ErrorFromServer: Decodable {
    var message: String
    var info: String
}

enum APIError {
    case invalidURL
    case invalidBody
    case invalidJSON
    case urlDomain
    case other(message: ErrorFromServer?)
    case unknow
    
    func message() -> String {
        let unknowErrorMessage = "Une erreur est survenue"
        
        switch self {
        case .urlDomain:
            return "Erreur de connexion"
        case .other(let wsError):
            return wsError?.message ?? wsError?.info ?? unknowErrorMessage
        default:
            return unknowErrorMessage
        }
    }
}
