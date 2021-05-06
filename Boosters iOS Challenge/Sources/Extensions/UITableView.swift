//
//  UITableView.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        String(describing: self)
    }
}

extension UITableView {
    func registerNib<T: UITableViewCell>(cellType: T.Type) {
        self.register(UINib(nibName: T.identifier, bundle: nil), forCellReuseIdentifier: T.identifier)
    }
    
    func dequeCell<T: UITableViewCell>(for indexPath: IndexPath) -> T? {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.identifier,
                                                  for: indexPath) as? T else { return nil }
        return cell
    }
}
