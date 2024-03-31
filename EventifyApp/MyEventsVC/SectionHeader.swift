//
//  HeaderReusableView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 31.03.2024.
//

import UIKit
import SnapKit

class SectionHeader: UICollectionReusableView {
    static let headerId = "headerId"

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        setupLayout()
    }

    private func setupLayout() {
        titleLabel.snp.makeConstraints({
            $0.top.trailing.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        })
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with text: String) {
        titleLabel.text = text
    }
}
