//
//  EventsViewCell.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 18.03.2024.
//

import UIKit
import SnapKit

class EventsViewCell: UICollectionViewCell {
    static let cellId = "eventsCell"
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
        return label
    }()

    private lazy var dayContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        return view
    }()

    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private lazy var timeContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        return view
    }()

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private lazy var audienceContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        return view
    }()

    private lazy var audienceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views
    private func setupViews() {
        contentView.addSubview(backgroundContainer)
        backgroundContainer.addSubviews(titleLabel, dayContainer, timeContainer, audienceContainer, qrImageView)
        dayContainer.addSubview(dayLabel)
        timeContainer.addSubview(timeLabel)
        audienceContainer.addSubview(audienceLabel)
    }

    // MARK: - Setup Layout
    private func setupLayout() {
        backgroundContainer.snp.makeConstraints({
            $0.top.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
        })

        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
        }

        dayContainer.snp.makeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(20)
        })

        dayLabel.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.width.equalTo(dayContainer.snp.width).inset(8)
        })

        timeContainer.snp.makeConstraints({
            $0.top.equalTo(dayContainer.snp.top)
            $0.leading.equalTo(dayContainer.snp.trailing).offset(8)
            $0.height.equalTo(20)
        })

        timeLabel.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.width.equalTo(timeContainer.snp.width).inset(8)
        })

        audienceContainer.snp.makeConstraints({
            $0.top.equalTo(dayContainer.snp.top)
            $0.leading.equalTo(timeContainer.snp.trailing).offset(8)
            $0.height.equalTo(20)
        })

        audienceLabel.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.width.equalTo(audienceContainer.snp.width).inset(8)
        })

        qrImageView.snp.makeConstraints({
            $0.top.bottom.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(77)
        })
    }

    func configureCell(model: EventsModel) {
        titleLabel.text = model.title
        dayLabel.text = model.day
        timeLabel.text = model.time
        audienceLabel.text = model.audience
        backgroundContainer.backgroundColor = UIColor(hex: model.color)
        qrImageView.image = model.qrCode
    }
}
