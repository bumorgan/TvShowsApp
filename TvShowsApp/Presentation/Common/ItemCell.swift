//
//  ItemCell.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import Foundation
import Kingfisher
import SnapKit
import UIKit

protocol ItemCellProtocol {
    var title: String { get }
    var imageUrl: URL? { get }
}

final class ItemCell: UITableViewCell {
    private lazy var titleLabel = UILabel()
    
    private lazy var imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imgView, titleLabel])
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.spacing = 16
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViewHierarchy()
        setupConstraints()
    }
    
    override func prepareForReuse() {
        imgView.kf.cancelDownloadTask()
        imgView.isHidden = false
        imgView.image = nil
        titleLabel.text = nil
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(contentStackView)
    }
    
    func setupConstraints() {
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        imgView.snp.makeConstraints {
            $0.size.equalTo(100)
        }
    }
    
    func setup(with item: ItemCellProtocol) {
        titleLabel.text = item.title
        guard let imageUrl = item.imageUrl else {
            imgView.isHidden = true
            return
        }
        imgView.kf.setImage(with: imageUrl)
    }
}
