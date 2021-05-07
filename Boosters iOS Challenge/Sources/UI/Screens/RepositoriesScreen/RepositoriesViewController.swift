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
        
        static let initial = Props(items: [])
    }
    
    private var props: Props = .initial
    private var repositories: [Repository] = []
    private var gitHubService = GitHubService()
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StoreLocator.shared.subscribe(self) {
            $0.select(RepositoriesViewState.init)
        }
        
        setupUI()
        
        self.getRepositories()
    }
    
    deinit {
        StoreLocator.shared.unsubscribe(self)
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

extension RepositoriesViewController {
    func getRepositories() {
        StoreLocator.shared.dispatch(AppStateAction.loadingRepositories)
        gitHubService.downloadRepositories {
            switch $0 {
            case .success(let repositories):
                StoreLocator.shared.dispatch(AppStateAction.loadedRepositories(repositories))
            case .error(let error):
                print("\(#function) \n Error - \(error.localizedDescription)")
            }
        }
    }
}

extension RepositoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRepo = self.repositories[indexPath.row]
        StoreLocator.shared.dispatch(AppStateAction.showRepositoryDetail(selectedRepo))
        
        self.showRepositoryDetailsScreen()
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
        self.repositories = state.repositories
        
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
