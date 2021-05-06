//
//  UIStoryboard.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import UIKit

enum Storyboard {
    static let repositories = UIStoryboard(name: "Repositories", bundle: nil)
    static let repositoryDetails = UIStoryboard(name: "RepositoryDetails", bundle: nil)
}

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self.self)
    }
}

extension UIStoryboard {
    func instantiate<T: StoryboardIdentifiable>() -> T {
        guard let vc = instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Controller is nil with the identifier: \(T.storyboardIdentifier)")
        }
        return vc
    }
}

extension UIViewController: StoryboardIdentifiable {}
