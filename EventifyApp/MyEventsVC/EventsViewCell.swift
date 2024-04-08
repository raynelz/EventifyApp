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

    private lazy var dayBackgroundContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#000000")
        view.layer.cornerRadius = 10
        view.addSubview(dayLabel)
        return view
    }()

    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .black
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
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private lazy var detailsStackView: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                dayBackgroundContainer,
                timeBackgroundContainer,
                audienceBackgroundContainer
            ]
        )
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 8
        return stack
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
        backgroundContainer.addSubviews(titleLabel, detailsStackView, qrImageView)
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

        detailsStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(qrImageView.snp.leading).offset(-16)
        }

        dayLabel.snp.makeConstraints({
            $0.verticalEdges.equalToSuperview().inset(4)
            $0.horizontalEdges.equalToSuperview().inset(8)
        })

        timeLabel.snp.makeConstraints({
            $0.verticalEdges.equalToSuperview().inset(4)
            $0.horizontalEdges.equalToSuperview().inset(8)
        })

        audienceLabel.snp.makeConstraints({
            $0.verticalEdges.equalToSuperview().inset(4)
            $0.horizontalEdges.equalToSuperview().inset(8)
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
