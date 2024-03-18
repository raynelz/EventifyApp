//
//  CategoriesCollectionViewCell.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 18.03.2024.
//

import UIKit
import SnapKit

class CategoriesCollectionViewCell: UICollectionViewCell {

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .medium)
        return label
    }()

    private lazy var containerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        imageView.clipsToBounds = true
        return imageView
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
        contentView.layer.cornerRadius = 10
        [textLabel, containerImageView].forEach({ contentView.addSubview($0) })

    }

    private func setupLayout() {
        contentView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.height.equalTo(160)
        }

        textLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(16)
            $0.leading.equalTo(contentView.snp.leading).offset(16)
            $0.trailing.equalTo(contentView.snp.trailing).offset(48)
        }

        containerImageView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
        }
    }

    func setText(text: String) {
        textLabel.text = text
    }

    func setImage(image: UIImage?) {
        containerImageView.image = image
    }

    func setColor(colorString: String) {
        contentView.backgroundColor = UIColor(hex: colorString)
    }

}
