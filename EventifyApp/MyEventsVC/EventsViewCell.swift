//
//  EventsViewCell.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 18.03.2024.
//

import UIKit
import SnapKit

class EventsViewCell: UICollectionViewCell {
    // MARK: UI Elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "День открытых дверей"
        label.textColor = .black
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()

    private lazy var dayBackgroundContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#000000")
        view.layer.cornerRadius = 10
        view.addSubview(dayLabel)
        return view
    }()

    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.text = "2 марта"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .black
        label.setMargins()
        return label
    }()

    private lazy var timeBackgroundContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#000000")
        view.layer.cornerRadius = 10
        view.addSubview(timeLabel)
        return view
    }()

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "17:30"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private lazy var audienceBackgroundContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#000000")
        view.layer.cornerRadius = 10
        view.addSubview(audienceLabel)
        return view
    }()

    private lazy var audienceLabel: UILabel = {
        let label = UILabel()
        label.text = "Б-3"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private lazy var detailsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [dayBackgroundContainer, timeBackgroundContainer, audienceBackgroundContainer])
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()

    private lazy var qrImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "qr")
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
        contentView.backgroundColor = UIColor(hex: "#F18EF0")
        contentView.layer.cornerRadius = 10

        [titleLabel, detailsStackView, qrImageView].forEach({ contentView.addSubview($0) })
    }

    // MARK: - Setup Layout
    private func setupLayout() {
        contentView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(108)
        }

        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
        }

        detailsStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }

        dayBackgroundContainer.snp.makeConstraints({
            $0.height.equalTo(20)
            $0.width.equalTo(83)
        })

        timeBackgroundContainer.snp.makeConstraints({
            $0.height.equalTo(20)
            $0.width.equalTo(83)
        })

        audienceBackgroundContainer.snp.makeConstraints({
            $0.height.equalTo(20)
            $0.width.equalTo(83)
        })


        dayLabel.snp.makeConstraints({
            $0.center.equalTo(dayBackgroundContainer.snp.center)
        })

        timeLabel.snp.makeConstraints({
            $0.center.equalTo(timeBackgroundContainer.snp.center)
        })

        audienceLabel.snp.makeConstraints({
            $0.center.equalTo(audienceBackgroundContainer.snp.center)
        })

        qrImageView.snp.makeConstraints({
            $0.top.bottom.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
        })
    }

    func configureCell(model: EventsModel) {
        titleLabel.text = model.title
        dayLabel.text = model.day
        timeLabel.text = model.time
        audienceLabel.text = model.audience
        contentView.backgroundColor = UIColor(hex: model.color)
        qrImageView.image = model.qrCode
    }
}
