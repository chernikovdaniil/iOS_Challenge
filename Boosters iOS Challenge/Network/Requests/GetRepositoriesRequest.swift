//
//  GetRepositoriesRequest.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 07.05.2021.
//

import Foundation
import Alamofire

class GetRepositoriesRequest {
    func downloadRepositories(completion: @escaping (RequestResult<[Repository]>) -> Void) {
        guard let urlRequest = try? GitHubRouter.getRepositories.asURLRequest() else {
            completion(.error(AppError.somethingWentWrong))
            return
        }
        
        Request.sendRequest(urlRequest,
                            responseModel: [Repository].self,
                            completion: completion)
    }
}
