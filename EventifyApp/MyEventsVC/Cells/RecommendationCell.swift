//
//  RecommendationCell.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 27.04.2024.
//
import SnapKit
import UIKit

final class RecommendationCell: UICollectionViewCell {
    // MARK: - UI Properties

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var likeButton: UIButton = {
        let image = UIImage(systemName: "heart")?.withTintColor(
            .brandPink,
            renderingMode: .alwaysOriginal
        ).resized(to: CGSize(width: 30, height: 25))

        let button = UIButton()
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        return button
    }()

    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()

    private lazy var tagsCollectionView = TagsCollectionView(items: [])

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.backgroundColor = .cellBackground
        contentView.layer.cornerRadius = 10
        contentView.addSubviews(
            imageView,
            likeButton,
            title,
            tagsCollectionView
        )
    }

    private func setupLayout() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }

        likeButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(12)
        }

        title.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }

        tagsCollectionView.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
    
    func configureLayout(for cell: FavoriteCellType) {
        switch cell {
        case .event:
            configureEvent()
        case .organizer:
            configureOrganizer()
        }
    }
    
    private func configureEvent() {
        imageView.snp.remakeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        title.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.layer.cornerRadius = 10
    }
    
    private func configureOrganizer() {
        imageView.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(33)
            $0.size.equalTo(100)
            $0.centerX.equalToSuperview()
        }
        
        title.snp.remakeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        imageView.layer.cornerRadius = 50
    }

    @objc
    func likeTapped(_ sender: UIButton) {
        let nameOfImage = sender.isSelected ? "heart" : "heart.fill"
        let image = UIImage(systemName: nameOfImage)?.withTintColor(
            UIColor(hex: "#F18EF0"),
            renderingMode: .alwaysOriginal
        ).resized(to: CGSize(width: 30, height: 25))

        sender.setImage(image, for: .normal)
        sender.isSelected.toggle()
    }
}

extension RecommendationCell: Configurable, Reusable {
    typealias DataType = MyEventsModel

    func configure(with model: DataType) {
        imageView.image = model.image
        title.text = model.name
        tagsCollectionView.items = model.items
    }
}

enum FavoriteCellType {
    case event
    case organizer
}
