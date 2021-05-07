//
//  AppState.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

struct AppState: StateType {
    var loadedRepositories: [Repository] = []
    
    var repositories: RepositoriesState = .initial
    var repositoriesDetail: RepositoryDetailsState = .initial
}

enum RepositoriesState: Equatable {
    case initial
    case loading
    case loaded([Repository])
}

enum RepositoryDetailsState: Equatable {
    case initial
    case show(Repository)
}

extension AppState: Equatable {
    static func == (lhs: AppState, rhs: AppState) -> Bool {
        return lhs.loadedRepositories == rhs.loadedRepositories &&
            lhs.repositories == rhs.repositories &&
            lhs.repositoriesDetail == rhs.repositoriesDetail
    }
}

func reduce(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()
    
    guard let action = action as? AppStateAction else { return state }
    
    switch action {
    case .loadingRepositories:
        state.repositories = .loading
    case .loadedRepositories(let repositories):
        state.loadedRepositories = repositories
        state.repositories = .loaded(repositories)
    case .showRepositoryDetail(let repository):
        state.repositoriesDetail = .show(repository)
    }
    
    return state
}
