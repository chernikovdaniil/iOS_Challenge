//
//  GitHubService.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import Foundation
import Alamofire

enum RequestResult<T> {
    case success(T)
    case error(Error)
}

class GitHubService {
    func downloadRepositories(completion: @escaping (RequestResult<[Repository]>) -> Void) {
        Alamofire.request(GitHubRouter.getRepositories).responseJSON { [weak self] in
            switch $0.result {
            case .success(let response):
                self?.decodeResponse(response,
                                    responseModel: [Repository].self,
                                    completion: completion)
            case .failure(let error):
                completion(.error(error))
            }
        }
    }
    
    func downloadDetails(by repository: String,
                      completion: @escaping (RequestResult<Repository>) -> Void) {
        Alamofire.request(GitHubRouter.getDetailsAt(repositoryName: repository)).responseJSON { [weak self] in
            guard let self = self else { return }
            switch $0.result {
            case .success(let response):
                self.decodeResponse(response, responseModel: Repository.self, completion: completion)
            case .failure(let error):
                completion(.error(error))
            }
        }
    }
    
    private func decodeResponse<T: Decodable>(_ response: Any, responseModel: T.Type,
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
