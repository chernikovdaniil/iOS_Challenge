//
//  GitHubRouter.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import Alamofire

enum GitHubRouter: URLRequestConvertible {
    private var basePath: String {
        "https://api.github.com"
    }
    
    case getRepositories
    case getDetailsAt(repositoryName: String)
    
    private var path: String {
        switch self {
        case .getRepositories: return "/orgs/AppSci/repos"
        case .getDetailsAt(let repositoryName): return "/repos/AppSci/\(repositoryName)"
        }
    }
    
    private var parameters: Parameters {
        switch self {
        default:
            return [:]
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getRepositories: return .get
        case .getDetailsAt: return .get
        }
    }
    
    private var headers: HTTPHeaders {
        switch self {
        default:
            return .init(["Accept" : "application/vnd.github.v3+json"])
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try self.basePath.asURL()
        let urlRequest = try URLRequest(url: url.appendingPathComponent(path),
                                        method: method,
                                        headers: headers)
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
    
}
