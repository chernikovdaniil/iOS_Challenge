//
//  RepositoriesPresenter.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import Foundation

struct RepositoriesPresenter {
    typealias Props = RepositoriesViewController.Props
    
    let render: (Props) -> Void
    let dispatch: (Action) -> Void
    let endObserving: () -> Void
    let onSelect: (Int) -> Void
    
    func present(state: AppState) {
        render(.init(items: items(state), onSelected: onSelect))
    }
    
    private func items(_ state: AppState) -> [RepositoryCell.Props] {
        state.repositoriesState.loadedRepositories.map {
            RepositoryCell.Props(ownerImageURL: $0.owner?.avatarURL, repoName: $0.name)
        }
    }
}
