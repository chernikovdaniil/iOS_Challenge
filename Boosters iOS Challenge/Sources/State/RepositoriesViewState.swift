//
//  RepositoriesState.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import Foundation

struct RepositoriesViewState {
    var repositories: [Repository]
    var props: RepositoriesViewController.Props
    var state: State; enum State {
        case initial
        case loading
        case loaded
        case fail
    }
    
    init(_ state: AppState) {
        self.repositories = state.loadedRepositories
        
        switch state.repositories {
        case .initial:
            self.repositories = []
            self.props = .initial
            self.state = .initial
        case .loading:
            self.repositories = []
            self.props = .initial
            self.state = .loading
        case .loaded(let repositories):
            self.repositories = repositories
            
            let items = makeItems(by: repositories)
            self.props = .init(items: items)
            self.state = .loaded
        }
    }
}

fileprivate
func makeItems(by loadedRepositories: [Repository]) -> [RepositoryCell.Props] {
    loadedRepositories.map {
        RepositoryCell.Props(ownerImageURL: $0.owner?.avatarURL, repoName: $0.name)
    }
}

extension RepositoriesViewState: Equatable {
    static func == (lhs: RepositoriesViewState, rhs: RepositoriesViewState) -> Bool {
        lhs.repositories == rhs.repositories && lhs.state == rhs.state
    }
}
