//
//  GitHubService.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 07.05.2021.
//

import Foundation

class GitHubService {
    static let shared = GitHubService()
    
    private let getRepositoriesRequest: GetRepositoriesRequest
    private let getRepositoryDetailsRequest: GetRepositoryDetailsRequest
    
    private init() {
        self.getRepositoriesRequest = .init()
        self.getRepositoryDetailsRequest = .init()
    }
    
    func getRepositories(completion: @escaping (RequestResult<[Repository]>) -> Void) {
        self.getRepositoriesRequest.downloadRepositories(completion: completion)
    }
    
    func getRepositoryDetails(by repository: String,
                              completion: @escaping (RequestResult<Repository>) -> Void) {
        self.getRepositoryDetailsRequest.downloadDetails(by: repository, completion: completion)
    }
    
}
