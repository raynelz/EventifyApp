//
//  ProfileHeaderView.swift
//  EventifyApp
//
//  Created by Рассказов Глеб on 03.05.2024.
//

import UIKit

final class ProfileHeaderView: UIView {
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "DEF14A")
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Иванов Иван"
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private lazy var editLabel: UILabel = {
        let label = UILabel()
        label.text = "Редактировать профиль"
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()

    private lazy var disclosure: UIImageView = {
        let imageView = UIImageView(
            image: UIImage(systemName: "chevron.right")?.withTintColor(
                .black,
                renderingMode: .alwaysOriginal
            )
        )
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let contentStack = makeContentStack()
        
        addSubviews(contentView)
        contentView.addSubviews(contentStack, disclosure)
        
        contentView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(80)
        }
        
        contentStack.snp.makeConstraints {
            $0.leading.verticalEdges.equalToSuperview().inset(16)
        }
        
        disclosure.snp.makeConstraints {
            $0.centerY.equalTo(contentStack.snp.centerY)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func makeContentStack() -> UIStackView {
        let stack = UIStackView(
            arrangedSubviews: [
                nameLabel,
                editLabel
            ]
        )
        stack.axis = .vertical
        stack.spacing = 4.0
        return stack
    }
}
