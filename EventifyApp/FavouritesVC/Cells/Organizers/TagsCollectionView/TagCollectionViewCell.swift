//
//  TagCollectionViewCell.swift
//  EventifyApp
//
//  Created by Рассказов Глеб on 11.05.2024.
//

import UIKit

final class TagCollectionViewCell: UICollectionViewCell {
    private let label: UILabel = {
        let insets = UIEdgeInsets(vertical: 4, horizontal: 8)
        let label = InsetLabel(insets: insets)
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.layer.borderWidth = 1.0
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        return label
    }()

    private var borderColor: UIColor? = .cellTint {
        didSet {
            label.layer.borderColor = borderColor?.cgColor
            label.textColor = borderColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            label.layer.borderColor = borderColor?.cgColor
        }
    }

    private func setupView() {
        contentView.addSubview(label)

        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension TagCollectionViewCell: Configurable, Reusable {
    typealias DataType = TagsModel

    func configure(with model: DataType) {
        label.text = model.text
        borderColor = model.borderColor
    }
}
