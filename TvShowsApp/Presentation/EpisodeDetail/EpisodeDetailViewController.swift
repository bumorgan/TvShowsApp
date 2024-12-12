//
//  EpisodeDetailViewController.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import SnapKit
import UIKit

protocol EpisodeDetailDisplaying: AnyObject {
    func display(_ episode: EpisodeDisplayingModel)
}

final class EpisodeDetailViewController: UIViewController {
    let interactor: EpisodeDetailInteracting
    
    public lazy var scrollView = UIScrollView()
    
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
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imgView, summaryLabel])
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.spacing = 16
        stackView.isHidden = true
        return stackView
    }()
    
    init(_ interactor: EpisodeDetailInteracting) {
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
        
        interactor.fetchEpisodeDetail()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func buildViewHierarchy() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentStackView)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
    }
}

extension EpisodeDetailViewController: EpisodeDetailDisplaying {
    func display(_ episode: EpisodeDisplayingModel) {
        contentStackView.isHidden = false
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.title = episode.title
            self.summaryLabel.text = episode.summary
            self.imgView.kf.setImage(with: episode.imageUrl)
        }
    }
}
