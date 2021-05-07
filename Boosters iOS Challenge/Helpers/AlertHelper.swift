//
//  AlertHelper.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 07.05.2021.
//

import UIKit

class AlertHelper {
    static func showAlert(title: String,
                          text: String? = nil,
                          actionTitle: String? = nil,
                          actionHandler: ((UIAlertAction) -> ())? = nil,
                          showCancel: Bool = false,
                          presenter: UIViewController) {
        let alertController = UIAlertController(title: title, message: text, preferredStyle: .alert)
        
        if let actionTitle = actionTitle {
            alertController.addAction(UIAlertAction(title: actionTitle,
                                                    style: .default,
                                                    handler: actionHandler))
        }
        if showCancel {
            alertController.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""),
                                                    style: .cancel, handler: nil))
        }
        DispatchQueue.main.async {
            presenter.present(alertController, animated: true)
        }
    }
}
