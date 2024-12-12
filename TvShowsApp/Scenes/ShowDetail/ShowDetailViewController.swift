//
//  ShowDetailViewController.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import SnapKit
import UIKit

protocol ShowDetailDisplaying: AnyObject {
    func display(_ show: ShowDetailDisplayingModel)
    func startLoading()
    func stopLoading()
    func displayError()
}

final class ShowDetailViewController: UIViewController, ErrorViewProtocol {
    let interactor: ShowDetailInteracting
    
    public lazy var scrollView = UIScrollView()
    
    public lazy var genresLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    public lazy var scheduleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    public lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .justified
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var episodesButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("See episode list", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imgView, genresLabel, scheduleLabel, summaryLabel, episodesButton])
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.spacing = 16
        stackView.isHidden = true
        return stackView
    }()
    
    private lazy var loading: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        return activity
    }()
    
    init(_ interactor: ShowDetailInteracting) {
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
        
        interactor.fetchShowDetail()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func buildViewHierarchy() {
        view.addSubview(scrollView)
        view.addSubview(loading)
        
        scrollView.addSubview(contentStackView)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        
        loading.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imgView.snp.makeConstraints {
            $0.height.equalTo(300)
        }
    }
}

@objc extension ShowDetailViewController {
    func didTapButton() {
        interactor.didTapEpisodesButton()
    }
}

extension ShowDetailViewController: ShowDetailDisplaying {
    func startLoading() {
        contentStackView.isHidden = true
        loading.startAnimating()
    }
    
    func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.loading.stopAnimating()
        }
    }
    
    func display(_ show: ShowDetailDisplayingModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.contentStackView.isHidden = false
            self.title = show.title
            self.genresLabel.text = show.genres
            self.scheduleLabel.text = show.schedule
            self.summaryLabel.text = show.summary
            self.imgView.kf.setImage(with: show.imageUrl)
        }
    }
    
    func displayError() {
        displayError() { [weak self] in
            self?.interactor.fetchShowDetail()
        }
    }
}
