//
//  RepositoryDetailsCell.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import UIKit

class RepositoryDetailsCell: UITableViewCell {
    struct Props {
        let title: String?
        let description: String?
        
        static let initial = Props(title: nil, description: nil)
    }
    
    private var props: Props = .initial
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    func render(_ props: Props) {
        self.props = props
        
        self.titleLabel.text = props.title
        self.descriptionLabel.text = props.description
    }
}
