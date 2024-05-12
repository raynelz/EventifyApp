//
//  CarouselViewCell.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 10.05.2024.
//

import SnapKit
import UIKit

final class CarouselViewCell: UICollectionViewCell {
    static let cellId = "CarouselViewCell"

    private lazy var carouselImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(carouselImageView)
    }

    private func setupLayout() {
        carouselImageView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(248)
        }
    }
}

extension CarouselViewCell: Reusable, Configurable {
    typealias DataType = UIImage

    func configure(with data: DataType) {
        carouselImageView.image = data
    }
}
