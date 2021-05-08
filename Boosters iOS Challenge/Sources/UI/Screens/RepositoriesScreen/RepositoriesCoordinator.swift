//
//  RepositoriesCoordinator.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 08.05.2021.
//

import UIKit
import ReSwift

protocol RepositoriesCoordinatorType {
    func start()
    func showRepositoryDetail()
}

class RepositoriesCoordinator: RepositoriesCoordinatorType {
    private weak var navigationController: UINavigationController?
    private let viewController: RepositoriesViewController = Storyboard.repositories.instantiate()
    private let store: Store<AppState>
    
    init(navigationController: UINavigationController?, store: Store<AppState>) {
        self.navigationController = navigationController
        self.store = store
        
        self.viewController.store = store
        self.viewController.coordinator = self
    }
    
    func start() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.setViewControllers([self.viewController], animated: true)
    }
    
    func showRepositoryDetail() {
        let coordinator = RepositoryDetailsCoordinator(navigationController: navigationController,
                                                       store: store)
        coordinator.start()
    }
}
