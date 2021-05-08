//
//  GetRepositoryDetailsRequest.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 07.05.2021.
//

import Foundation
import Alamofire

class GetRepositoryDetailsRequest {
    func downloadDetails(by repository: String,
                         completion: @escaping (RequestResult<Repository>) -> Void) {
        guard let urlRequest = try? GitHubRouter
                .getDetailsAt(repositoryName: repository).asURLRequest() else {
            completion(.error(AppError.somethingWentWrong))
            return
        }
        
        Request.sendRequest(urlRequest, responseModel: Repository.self, completion: completion)
    }
}
