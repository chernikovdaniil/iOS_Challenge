//
//  AppCoordinator.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import UIKit

class AppCoordinator: NSObject {
    private let navigationController: UINavigationController
    private var disposable: Disposable?
    private var window: UIWindow
    private let store: Store<AppState>
    
    init(window: UIWindow, store: Store<AppState> = StoreLocator.shared) {
        self.navigationController = UINavigationController()
        self.window = window
        self.store = store
        
        self.window.rootViewController = self.navigationController
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        let repositoriesRouter = RepositoriesRouter(navigationController: self.navigationController)
        repositoriesRouter.start()
    }
}
