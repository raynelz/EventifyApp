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
        label.textColor = .label
        label.layer.borderColor = UIColor.cellTint.cgColor
        label.layer.borderWidth = 1.0
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        return label
    }()
    
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
            label.layer.borderColor = UIColor.cellTint.cgColor
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
    typealias DataType = String
    
    func configure(with model: String) {
        label.text = model
    }
}
