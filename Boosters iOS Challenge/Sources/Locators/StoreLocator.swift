//
//  StoreLocator.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import ReSwift

enum StoreLocator {
    private static var instance: Store<AppState>?
    
    static func populate(instance: Store<AppState>) {
        self.instance = instance
    }
    
    static var shared: Store<AppState> {
        guard let instance = instance else { fatalError("Store not exist") }
        return instance
    }
}
