//
//  AppStateAction.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 07.05.2021.
//

import ReSwift

enum AppStateAction: Action {
    case loadingRepositories
    case loadedRepositories([Repository])
    
    case showRepositoryDetail(Repository)
}
