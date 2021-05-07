//
//  RepositoryDetailsSection.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import Foundation

struct RepositoryDetailsSection {
    let ownerImageURL: URL?
    let repoName: String?
    
    let items: [RepositoryDetailsItem]
}

struct RepositoryDetailsItem {
    let description: String?
}
