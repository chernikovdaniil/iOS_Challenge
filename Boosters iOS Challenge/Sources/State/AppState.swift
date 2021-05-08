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
    case show
    case loadedDetails(Repository)
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
    
    switch action {
    case is LoadingRepositoriesAction:
        state.repositories = .loading
    case let action as LoadedRepositoriesAction:
        state.loadedRepositories = action.repositories
        state.repositories = .loaded(action.repositories)
    case is ShowRepositoryDetailAction:
        state.repositoriesDetail = .show
    case let action as LoadedRepositoryDetailsAction:
        state.repositoriesDetail = .loadedDetails(action.repository)
    default:
        break
    }
    
    return state
}
