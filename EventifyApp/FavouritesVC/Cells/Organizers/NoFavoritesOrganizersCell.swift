//
//  NoFavoritesOrganizersCell.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 28.04.2024.
//
import UIKit
import SnapKit

final class NoFavoritesOrganizersCell: UICollectionViewCell {
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(hex: "#858591")
        imageView.image = UIImage(systemName: "heart")?.withTintColor(
            UIColor(hex: "#858591"),
            renderingMode: .alwaysOriginal
        ).resized(to: CGSize(width: 120, height: 100))
        return imageView
    }()

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Нажмите на сердце на странице\nили карточке организатора,\nчтобы добавить его в список"
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(hex: "#858591")
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        contentView.addSubviews(iconImageView, textLabel)
    }

    private func setupLayout() {
        iconImageView.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.height.equalTo(115)
        })

        textLabel.snp.makeConstraints({
            $0.top.equalTo(iconImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        })
    }
}

extension NoFavoritesOrganizersCell: Configurable, Reusable {
    typealias DataType = Void
    func configure(with data: DataType) {}
}
