//
//  DetailsView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 03.04.2024.
//

import UIKit
import SnapKit

struct DetailModel {
    let id: Int
    let title: String
}

final class DetailsView: UIView {
    private lazy var backgroundContainer: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
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
        backgroundColor = UIColor(hex: "#DDF14A")
        layer.cornerRadius = 16
        addSubview(backgroundContainer)
        backgroundContainer.addSubview(titleLabel)
    }

    private func setupLayout() {
        backgroundContainer.snp.makeConstraints {
            $0.edges.equalTo(snp.edges)
        }
        titleLabel.snp.makeConstraints({
            $0.horizontalEdges.equalTo(backgroundContainer.snp.horizontalEdges).inset(16)
            $0.verticalEdges.equalTo(backgroundContainer.snp.verticalEdges).inset(8)
        })
    }

    func setText(with model: DetailModel) {
        titleLabel.text = model.title
    }
}
