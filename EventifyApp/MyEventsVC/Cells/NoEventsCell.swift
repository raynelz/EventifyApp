//
//  NoEventsCell.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 28.04.2024.
//

import UIKit
import SnapKit

final class NoEventsCell: UICollectionViewCell {
    static let cellId = "NoEventsCell"

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(hex: "#858591")
        imageView.image = UIImage(systemName: "bookmark")?.withTintColor(
            UIColor(hex: "#858591"),
            renderingMode: .alwaysOriginal
        ).resized(to: CGSize(width: 100, height: 100))
        return imageView
    }()

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Нет предстоящих\nмероприятий"
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