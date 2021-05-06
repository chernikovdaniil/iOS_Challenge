//
//  AppState.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//


struct AppState {
    var repositoriesState: RepositoriesState
    var respositoryDetailsState: RepositoryDetailsState
    
    static let initial = AppState(repositoriesState: .initial, respositoryDetailsState: .initial)
}

func reduce(_ state: AppState, _ action: Action) -> AppState {
    return .init(repositoriesState: reduce(state.repositoriesState, action),
                 respositoryDetailsState: reduce(state.respositoryDetailsState, action))
}
