//
//  Request.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 07.05.2021.
//

import Foundation
import Alamofire

enum RequestResult<T> {
    case success(T)
    case error(Error)
}

class Request {
    static func sendRequest<T: Decodable>(_ urlRequest: URLRequest,
                               responseModel: T.Type,
                               completion: @escaping (RequestResult<T>) -> Void) {
        Alamofire.request(urlRequest).responseJSON {
            switch $0.result {
            case .success(let response):
                self.decodeResponse(response,
                                    responseModel: responseModel.self,
                                     completion: completion)
            case .failure(let error):
                completion(.error(error))
            }
        }
    }
    
    static private func decodeResponse<T: Decodable>(_ response: Any, responseModel: T.Type,
                                              completion: @escaping (RequestResult<T>) -> Void) {
        do {
            let data = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
            let model = try JSONDecoder().decode(T.self, from: data)
            completion(.success(model))
        } catch {
            completion(.error(error))
        }
    }
}
