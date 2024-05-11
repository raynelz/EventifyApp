//
//  OrganizerCell.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 28.04.2024.
//
import SnapKit
import UIKit

final class OrganizerCell: UICollectionViewCell {
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
        contentView.layer.cornerRadius = 12
        contentView.addSubviews(
            imageView,
            likeButton,
            title,
            tagsCollectionView
        )
    }

    private func setupLayout() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(33)
            $0.centerX.equalToSuperview()
        }

        likeButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(4)
        }

        title.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }

        tagsCollectionView.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
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

extension OrganizerCell: Configurable, Reusable {
    typealias DataType = MyEventsModel

    func configure(with model: DataType) {
        imageView.image = model.image
        title.text = model.name
        tagsCollectionView.items = model.items
    }
}
