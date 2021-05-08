//
//  RepositoryDetailsCoordinator.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 08.05.2021.
//

import UIKit
import ReSwift

protocol RepositoryDetailsCoordinatorType {
    func start()
}

class RepositoryDetailsCoordinator: RepositoryDetailsCoordinatorType {
    private weak var navigationController: UINavigationController?
    private let viewController: RepositoryDetailsViewController = Storyboard.repositoryDetails.instantiate()
    
    init(navigationController: UINavigationController?, store: Store<AppState>) {
        self.navigationController = navigationController
        
        self.viewController.store = store
    }
    
    func start() {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
