//
//  RepositoryDetailsViewController.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import UIKit
import ReSwift

class RepositoryDetailsViewController: UIViewController {
    struct Props {
        let header: RepositoryDetailsHeader.Props
        let items: [RepositoryDetailsCell.Props]
        
        static let initial: Props = .init(header: .initial, items: [])
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var props: Props = .initial
    
    var store: Store<AppState>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.store?.subscribe(self) {
            $0.select(RepositoryDetailsViewState.init)
        }
        
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.store?.unsubscribe(self)
    }
    
    private func setupUI() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        
        let footerView = UIView(frame: .init(x: 0.0, y: 0.0, width: 0.0, height: 0.01))
        self.tableView.tableFooterView = footerView
        
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        170.0
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

extension RepositoryDetailsViewController: StoreSubsriber {
    typealias StoreSubscriberStateType = RepositoryDetailsViewState
    
    func newState(state: RepositoryDetailsViewState) {
        
        switch state.state {
        case .loading:
            self.showActivityIndicator()
        case .loaded:
            self.hideActivityIndicator()
        }
        
        self.render(state.props)
    }
}
