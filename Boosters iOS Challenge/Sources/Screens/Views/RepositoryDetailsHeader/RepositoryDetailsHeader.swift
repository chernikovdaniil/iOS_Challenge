//
//  RepositoryDetailsHeader.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import UIKit

class RepositoryDetailsHeader: UIView {
    struct Props {
        let ownerImageURL: URL?
        let repoName: String?
        
        static let initial = Props(ownerImageURL: nil, repoName: nil)
    }
    
    private var props: Props = .initial
    
    @IBOutlet private weak var ownerImageView: UIImageView!
    @IBOutlet private weak var repoNameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        nibSetup()
    }
    
    private func nibSetup() {
        let subView = loadViewFromNib()
        setupView(subView: subView)
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let nibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return UIView()
        }
        return nibView
    }
    
    private func setupView(subView: UIView) {
        backgroundColor = .clear
        subView.frame = bounds
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subView)
        self.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: 0).isActive = true
        self.topAnchor.constraint(equalTo: subView.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: 0).isActive = true
        subView.backgroundColor = .clear
    }
}

extension RepositoryDetailsHeader {
    func render(_ props: Props) {
        self.props = props
        
        self.ownerImageView.load(from: props.ownerImageURL)
        self.repoNameLabel.text = props.repoName
    }
}
