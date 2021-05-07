//
//  AppDelegate.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import UIKit
import ReSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private lazy var store: Store<AppState> = {
        .init(reducer: reduce, state: .none)
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
        
        StoreLocator.populate(instance: store)
        
        self.startApp()
        return true
    }
    
    private func startApp() {
        guard let window = self.window else { return }
        let appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
    }
}
