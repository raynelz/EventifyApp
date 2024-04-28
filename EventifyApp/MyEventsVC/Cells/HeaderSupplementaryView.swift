//
//  HeaderSupplementaryView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 27.04.2024.
//

import UIKit
import SnapKit

final class HeaderSupplementaryView: UICollectionReusableView {
    static let headerId = "HeaderSupplementaryView"
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
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
        addSubviews(headerLabel)
    }

    private func setupLayout() {
        headerLabel.snp.makeConstraints({
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
        })
    }

    func configurateHeader(categoryName: String) {
        headerLabel.text = categoryName
    }
}
