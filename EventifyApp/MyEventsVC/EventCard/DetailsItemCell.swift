//
//  DetailsItemCell.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 08.04.2024.
//

import UIKit
import SnapKit

class DetailsItemCell: UICollectionViewCell, Reusable {
    private lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.backgroundColor = UIColor(hex: "DDF14A")
        contentView.layer.cornerRadius = 16
        contentView.addSubview(title)
    }

    private func setupLayout() {
        title.snp.makeConstraints({
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.verticalEdges.equalToSuperview().inset(8)
        })
    }

    func configure(with model: DetailModel) {
        title.text = model.title
    }

}
