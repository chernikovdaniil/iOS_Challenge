//
//  RepositoryDetailsViewController.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import UIKit

class RepositoryDetailsViewController: UIViewController {
    struct Props {
        let header: RepositoryDetailsHeader.Props
        let items: [RepositoryDetailsCell.Props]
        
        static let initial: Props = .init(header: .initial, items: [])
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var props: Props = .initial
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.registerNib(cellType: RepositoryDetailsCell.self)
    }
    
    func render(_ props: Props) {
        self.props = props
        
        self.tableView.reloadData()
    }
}

extension RepositoryDetailsViewController: UITableViewDelegate {
    
}

extension RepositoryDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = RepositoryDetailsHeader()
        header.render(props.header)
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.props.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: RepositoryDetailsCell = tableView
                .dequeCell(for: indexPath) else { return .init() }
        cell.render(self.props.items[indexPath.row])
        return cell
    }
}
