//
//  RepositoryDetailsAction.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

struct RepositoryDetailsLoadingAction: Action {}
struct RepositoryDetailsLoadedAction: Action {
    let repository: Repository
}
