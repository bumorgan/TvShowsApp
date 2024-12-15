//
//  ShowsViewController.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import UIKit

protocol ShowsDisplaying: AnyObject {
    func display(_ shows: [ShowDisplayingModel])
    func displaySearchResult(_ shows: [ShowDisplayingModel])
    func startLoading()
    func stopLoading()
    func displayError()
}

final class ShowsViewController: UIViewController, ErrorViewProtocol {
    let interactor: ShowsInteracting
    
    private var displayedShows = [ShowDisplayingModel]()
    
    private lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = "Search"
        search.searchBar.delegate = self
        search.obscuresBackgroundDuringPresentation = false
        return search
    }()
    
    private lazy var loading: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        return activity
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ItemCell.self, forCellReuseIdentifier: "ItemCellIdentifier")
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        return tableView
    }()
    
    init(_ interactor: ShowsInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle:nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        buildViewHierarchy()
        setupConstraints()
        
        interactor.fetchShows()
    }
    
    private func configureView() {
        title = "Shows"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        view.backgroundColor = .systemBackground
    }
    
    private func buildViewHierarchy() {
        view.addSubview(tableView)
        view.addSubview(loading)
    }
    
    private func setupConstraints() {
        loading.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ShowsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        interactor.didSelectShow(with: displayedShows[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == displayedShows.count - 1 {
            interactor.fetchShows()
        }
    }
}

extension ShowsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCellIdentifier", for: indexPath) as? ItemCell else {
            return UITableViewCell()
        }
        cell.setup(with: displayedShows[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension ShowsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        interactor.searchShow(with: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        interactor.cancelSearch()
    }
}

extension ShowsViewController: ShowsDisplaying {
    func display(_ shows: [ShowDisplayingModel]) {
        displayedShows = shows
        reloadTableView()
    }
    
    func displaySearchResult(_ shows: [ShowDisplayingModel]) {
        displayedShows = shows
        reloadTableView()
    }
    
    func startLoading() {
        loading.startAnimating()
    }
    
    func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.loading.stopAnimating()
        }
    }
    
    func displayError() {
        displayError() { [weak self] in
            self?.interactor.fetchShows()
        }
    }
}

private extension ShowsViewController {
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
}
