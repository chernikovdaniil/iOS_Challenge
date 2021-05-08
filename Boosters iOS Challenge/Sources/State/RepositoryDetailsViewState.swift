//
//  RepositoryDetailsState.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import Foundation

struct RepositoryDetailsViewState: StateType {
    var repository: Repository
    var props: RepositoryDetailsViewController.Props
    var state: State; enum State {
        case loading
        case loaded
    }
    
    init(_ state: AppState) {
        switch state.repositoriesDetail {
        case .initial, .show:
            self.repository = .initial
            self.props = .initial
            self.state = .loading
        case .loadedDetails(let repository):
            self.repository = repository
            let header = getHeader(by: repository)
            let items = getItems(by: repository)
            
            self.props = .init(header: header,
                               items: items)
            self.state = .loaded
        }
    }
}

fileprivate
func getHeader(by repo: Repository) -> RepositoryDetailsHeader.Props {
    .init(ownerImageURL: repo.owner?.avatarURL, repoName: repo.name)
}

fileprivate
func getItems(by repo: Repository) -> [RepositoryDetailsCell.Props] {
    return [
        .init(title: "Created At", description: repo.createdAt?
                .convertToString(format: "EEEE, MMM d, yyyy")),
        .init(title: "Last Commit", description: repo.updatedAt?
                .convertToString(format: "EEEE, MMM d, yyyy"))
    ]
}
