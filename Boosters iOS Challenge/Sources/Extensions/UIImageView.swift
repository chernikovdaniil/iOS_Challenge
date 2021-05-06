//
//  UIImageView.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import UIKit

extension UIImageView {
    func load(from imageURL: URL?,
              completion: (() -> Void)? = nil) {
        self.image = nil
        guard let url = imageURL else { return }
        ImageCacher.shared.load(from: url) { image in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.image = image
            }
        }
    }
}
