//
//  RepositoriesRouter.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import UIKit

class RepositoriesRouter {
    private let store: Store<AppState>
    private weak var navigationController: UINavigationController?
    
    init(store: Store<AppState> = StoreLocator.shared, navigationController: UINavigationController?) {
        self.store = store
        self.navigationController = navigationController
    }
    
    func start() {
        let controller: RepositoriesViewController = Storyboard.repositories.instantiate()
        var disposable: Disposable?
        
        let endObserving: () -> Void = {
            disposable?.dispose()
        }
        
        let dispatcher: (Action) -> Void = { [weak self] in
            guard let self = self else { return }
            self.store.dispatch($0)
        }
        
        let render: (RepositoriesViewController.Props) -> Void = { [weak controller] in
            controller?.render($0)
        }
        
        let presenter = RepositoriesPresenter(render: render,
                                              dispatch: dispatcher,
                                              endObserving: endObserving) { _ in
        }
        
        disposable = store.subscribe(observer: presenter.present)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.setViewControllers([controller], animated: true)
    }
}
