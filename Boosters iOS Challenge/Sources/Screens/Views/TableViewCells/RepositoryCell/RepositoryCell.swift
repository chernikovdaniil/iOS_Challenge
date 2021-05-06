//
//  RepositoryCell.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import UIKit

class RepositoryCell: UITableViewCell {
    struct Props {
        let ownerImageURL: URL?
        let repoName: String?
        
        static let initial = Props(ownerImageURL: nil, repoName: nil)
    }
    
    private var props: Props = .initial
    
    @IBOutlet private weak var ownerImageView: UIImageView!
    @IBOutlet private weak var repositoryNameLabel: UILabel!
    
    func render(_ props: Props) {
        self.props = props
        
        self.ownerImageView.load(from: props.ownerImageURL)
        self.repositoryNameLabel.text = props.repoName
    }
}
