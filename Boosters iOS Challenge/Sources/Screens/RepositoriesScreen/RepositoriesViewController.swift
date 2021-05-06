//
//  RepositoriesViewController.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import UIKit

class RepositoriesViewController: UIViewController {
    struct Props {
        let items: [RepositoryCell.Props]
        let onSelected: (Int) -> Void
        
        static let initial = Props(items: [], onSelected: { _ in })
    }
    
    private var props: Props = .initial
    
    @IBOutlet private weak var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.tableView?.registerNib(cellType: RepositoryCell.self)
    }
    
    func render(_ props: Props) {
        self.props = props
        self.tableView?.reloadData()
    }
}

extension RepositoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.props.onSelected(indexPath.row)
    }
}

extension RepositoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        props.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: RepositoryCell = tableView.dequeCell(for: indexPath) else { return .init() }
        cell.render(props.items[indexPath.row])
        return cell
    }
}
