//
//  RequestManager.swift
//  GithubIssues
//
//  Created by Martin Kuvandzhiev on 20.12.20.
//

import Foundation
import Alamofire
import Combine


enum API: String, URLConvertible {
    case issues = "/repos/apple/swift-package-manager/issues"
    
    func asURL() -> URL {
        return URL(string: API.baseURL + self.rawValue)!
    }
}

extension API {
    static let baseURL = "https://api.github.com"
}

class RequestManager {
    class func fetchIssues(completion: @escaping ((_ issues: Issues?, _ error: Error?) -> Void)) {
        AF.request(API.issues, method: .get).responseJSON { (response) in
            guard response.error == nil else {
                completion(nil, response.error)
                return
            }
            
            guard let responseJsonArray = response.value as? [[String: Any]] else {
                completion(nil, RequestError.cannotParseData)
                return
            }
            
            let issues = responseJsonArray.map({Issue(value: $0)})
            
            completion(issues, nil)
            return
        }
    }
    
    
    class func fetchIssuesCombine() -> AnyPublisher<Issues, Error> {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        return URLSession.shared.dataTaskPublisher(for: API.issues.asURL())
            .tryMap{ output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw RequestError.statusCodeFailure
                }
                return output.data
            }
            .decode(type: Issues.self, decoder: jsonDecoder)
            .mapError({_ in RequestError.cannotParseData})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension RequestManager {
    enum RequestError: Error {
        case statusCodeFailure
        case cannotParseData
    }
}
