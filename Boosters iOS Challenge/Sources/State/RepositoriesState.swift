//
//  RepositoriesState.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import Foundation

struct RepositoriesState {
    var loadedRepositories: [Repository]
    var state: State; enum State {
        case initial
        case loading
        case loaded
    }
    
    static let initial = RepositoriesState(loadedRepositories: [], state: .initial)
}

func reduce(_ state: RepositoriesState, _ action: Action) -> RepositoriesState {
    var state = state
    
    switch action {
    case is RepositoriesLoadingAction:
        state.state = .loading
        return state
    case let action as RepositoriesLoadedAction:
        state.state = .loaded
        state.loadedRepositories = action.repositories
        return state
    default:
        return state
    }
}
