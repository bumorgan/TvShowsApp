//
//  EpisodesViewController.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import UIKit

protocol EpisodesDisplaying: AnyObject {
    func display(_ episodes: [EpisodeDisplayingModel])
    func startLoading()
    func stopLoading()
    func displayError()
}

final class EpisodesViewController: UIViewController, ErrorViewProtocol {
    let interactor: EpisodesInteracting
    
    private var displayedEpisodes = [EpisodeDisplayingModel]()
    
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
    
    init(_ interactor: EpisodesInteracting) {
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
        
        interactor.fetchEpisodes()
    }
    
    private func configureView() {
        title = "Episodes"
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

extension EpisodesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        interactor.didSelectEpisode(displayedEpisodes[indexPath.row])
    }
}

extension EpisodesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedEpisodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCellIdentifier", for: indexPath) as? ItemCell else {
            return UITableViewCell()
        }
        cell.setup(with: displayedEpisodes[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension EpisodesViewController: EpisodesDisplaying {
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
            self?.interactor.fetchEpisodes()
        }
    }
    
    func display(_ episodes: [EpisodeDisplayingModel]) {
        displayedEpisodes = episodes
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
}
