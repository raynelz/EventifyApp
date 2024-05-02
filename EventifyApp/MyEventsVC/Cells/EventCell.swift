//
//  EventCell.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 26.04.2024.
//

import SnapKit
import UIKit

class EventCell: UICollectionViewCell {
    
    // MARK: UI Elements

    private lazy var backgroundContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()

    private lazy var dayContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        return view
    }()

    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    private lazy var timeContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        return view
    }()

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    private lazy var locationContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        return view
    }()

    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    private lazy var qrImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubview(backgroundContainer)
        backgroundContainer.addSubviews(
            titleLabel,
            dayContainer,
            timeContainer,
            locationContainer,
            qrImageView
        )
        dayContainer.addSubview(dayLabel)
        timeContainer.addSubview(timeLabel)
        locationContainer.addSubview(locationLabel)
    }

    // MARK: - Setup Layout

    private func setupLayout() {
        backgroundContainer.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
        }

        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(qrImageView.snp.leading)
        }

        dayContainer.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(20)
        }

        dayLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(dayContainer.snp.width).inset(8)
        }

        timeContainer.snp.makeConstraints {
            $0.top.equalTo(dayContainer.snp.top)
            $0.leading.equalTo(dayContainer.snp.trailing).offset(8)
            $0.height.equalTo(20)
        }

        timeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(timeContainer.snp.width).inset(8)
        }

        locationContainer.snp.makeConstraints {
            $0.top.equalTo(dayContainer.snp.top)
            $0.leading.equalTo(timeContainer.snp.trailing).offset(8)
            $0.height.equalTo(20)
        }

        locationLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(locationContainer.snp.width).inset(8)
        }

        qrImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(77)
        }
    }
}

extension EventCell: Configurable, Reusable {
    typealias DataType = MyEventsModel
    
    func configure(with model: DataType) {
        titleLabel.text = model.name
        dayLabel.text = model.date
        timeLabel.text = model.time
        locationLabel.text = model.location
        backgroundContainer.backgroundColor = UIColor(hex: model.color)
        qrImageView.image = model.image
    }
}
