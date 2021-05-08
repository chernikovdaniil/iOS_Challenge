//
//  RepositoriesViewController.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import UIKit
import ReSwift

class RepositoriesViewController: UIViewController {
    struct Props {
        let items: [RepositoryCell.Props]
        
        static let initial = Props(items: [])
    }
    
    private var props: Props = .initial
    
    var store: Store<AppState>?
    var coordinator: RepositoriesCoordinatorType?
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.store?.subscribe(self) {
            $0.select(RepositoriesViewState.init)
        }
        
        setupUI()
        
        self.store?.dispatch(LoadingRepositoriesAction())
    }
    
    deinit {
        self.store?.unsubscribe(self)
    }
    
    private func setupUI() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.tableView.registerNib(cellType: RepositoryCell.self)
    }
    
    func render(_ props: Props) {
        self.props = props
        self.tableView.reloadData()
    }
}

extension RepositoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedRepo = self.store?.state.loadedRepositories[indexPath.row] else { return }
        StoreLocator.shared.dispatch(ShowRepositoryDetailAction(repository: selectedRepo))
        
        self.coordinator?.showRepositoryDetail()
    }
    
    private func showRepositoryDetailsScreen() {
        let controller: RepositoryDetailsViewController = Storyboard.repositoryDetails.instantiate()
        self.navigationController?.pushViewController(controller, animated: true)
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

extension RepositoriesViewController: StoreSubsriber {
    typealias StoreSubscriberStateType = RepositoriesViewState
    
    func newState(state: RepositoriesViewState) {
        switch state.state {
        case .loading:
            self.showActivityIndicator()
        case .loaded:
            self.hideActivityIndicator()
        default:
            break
        }
        
        self.render(state.props)
    }
}
