//
//  AppStateAction.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 07.05.2021.
//

import ReSwift

struct LoadingRepositoriesAction: Action {
    init() {
        GitHubService.shared.getRepositories {
            switch $0 {
            case .success(let model):
                StoreLocator.shared.dispatch(LoadedRepositoriesAction(repositories: model))
            case .error(let error):
                StoreLocator.shared.dispatch(ActionFail(error: error))
            }
        }
    }
}

struct LoadedRepositoriesAction: Action {
    let repositories: [Repository]
}

struct ShowRepositoryDetailAction: Action {
    init(repository: Repository) {
        GitHubService.shared.getRepositoryDetails(by: repository.name ?? "") {
            switch $0 {
            case .success(let model):
                StoreLocator.shared.dispatch(LoadedRepositoryDetailsAction(repository: model))
            case .error(let error):
                StoreLocator.shared.dispatch(ActionFail(error: error))
            }
        }
    }
}

struct LoadedRepositoryDetailsAction: Action {
    let repository: Repository
}

struct ActionFail: Action {
    let error: Error
}

struct AppError: Error {
    let title: String
    let message: String
    
    init(_ title: String, _ message: String) {
        self.title = title
        self.message = message
    }
    
    var errorDescription: String? {
        return "\(title) \n \(message)"
    }
}

extension AppError {
    static let somethingWentWrong = AppError("Oops...",
                                             "Something went wrong.")
}
