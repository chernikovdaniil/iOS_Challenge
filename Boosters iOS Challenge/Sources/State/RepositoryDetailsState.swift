//
//  RepositoryDetailsState.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//


struct RepositoryDetailsState {
    var repository: Repository
    
    static let initial = RepositoryDetailsState(repository: .initial)
}

func reduce(_ state: RepositoryDetailsState, _ action: Action) -> RepositoryDetailsState {
    var state = state
    
    switch action {
    case let action as RepositorySelectedAction:
        state.repository = action.repository
        return state
    default:
        return state
    }
}
