//
//  RepositoriesAction.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

struct RepositorySelectedAction: Action {
    let repository: Repository
}

struct RepositoriesLoadingAction: Action {}
struct RepositoriesLoadedAction: Action {
    let repositories: [Repository]
}
