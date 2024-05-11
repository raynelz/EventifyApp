//
//  EventCell.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 26.04.2024.
//

import SnapKit
import UIKit

class EventCell: UICollectionViewCell {
    // MARK: UI Elements

    private lazy var backgroundContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()

    private lazy var tagsCollectionView = TagsCollectionView(items: [])

    private lazy var qrImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubview(backgroundContainer)
        backgroundContainer.addSubviews(
            titleLabel,
            tagsCollectionView,
            qrImageView
        )
    }

    // MARK: - Setup Layout

    private func setupLayout() {
        backgroundContainer.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
        }

        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(qrImageView.snp.leading)
            $0.height.equalTo(42)
        }

        tagsCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }

        qrImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(77)
        }
    }
}

extension EventCell: Configurable, Reusable {
    typealias DataType = MyEventsModel

    func configure(with model: DataType) {
        titleLabel.text = model.name
        tagsCollectionView.items = model.items
        qrImageView.image = model.image
        
        if let color = model.color {
            backgroundContainer.backgroundColor = UIColor(hex: color)
        }
    }
}
