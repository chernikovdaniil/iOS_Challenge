//
//  GitHubService.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import Foundation
import Alamofire

class GitHubService {
    func getRepositories(completion: @escaping (Result<[Repository], Error>) -> Void) {
        AF.request(GitHubRouter.getRepositories).responseData { [weak self] in
            guard let self = self else { return }
            switch $0.result {
            case .success(let response):
                self.decodeResponse(response,
                                    responseModel: [Repository].self,
                                    completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getDetailsBy(repositoryName: String,
                      completion: @escaping (Result<Repository, Error>) -> Void) {
        AF.request(GitHubRouter.getDetailsAt(repositoryName: repositoryName)).responseData { [weak self] in
            guard let self = self else { return }
            switch $0.result {
            case .success(let response):
                self.decodeResponse(response, responseModel: Repository.self, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func decodeResponse<T: Decodable>(_ response: Data, responseModel: T.Type,
                                completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let data = try JSONDecoder().decode(T.self, from: response)
            completion(.success(data))
        } catch {
            completion(.failure(error))
        }
    }
}
