//
//  RecommendationCell.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 27.04.2024.
//
import UIKit
import SnapKit

final class RecommendationCell: UICollectionViewCell {

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(
            UIImage(systemName: "heart")?.withTintColor(
                UIColor(hex: "#F18EF0"),
                renderingMode: .alwaysOriginal
            ).resized(to: CGSize(width: 30, height: 25)),
            for: .normal
        )
        button.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        return button
    }()

    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    private lazy var dayContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.layer.masksToBounds = true
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
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.layer.masksToBounds = true
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
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var audienceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
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
        contentView.backgroundColor = .black
        contentView.layer.cornerRadius = 10
        contentView.addSubviews(
            imageView,
            likeButton,
            title,
            dayContainer,
            timeContainer,
            audienceContainer
        )
        dayContainer.addSubview(dayLabel)
        timeContainer.addSubview(timeLabel)
        audienceContainer.addSubview(audienceLabel)
    }

    private func setupLayout() {
        imageView.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        })

        likeButton.snp.makeConstraints({
            $0.top.trailing.equalToSuperview().inset(4)
        })

        title.snp.makeConstraints({
            $0.top.equalTo(imageView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(16)
        })

        dayContainer.snp.makeConstraints({
            $0.top.equalTo(title.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(20)
        })

        dayLabel.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.width.equalTo(dayContainer.snp.width).inset(8)
        })

        timeContainer.snp.makeConstraints({
            $0.top.equalTo(dayContainer.snp.top)
            $0.leading.equalTo(dayContainer.snp.trailing).offset(4)
            $0.height.equalTo(20)
        })

        timeLabel.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.width.equalTo(timeContainer.snp.width).inset(8)
        })

        audienceContainer.snp.makeConstraints({
            $0.top.equalTo(dayContainer.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(20)
        })

        audienceLabel.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.width.equalTo(audienceContainer.snp.width).inset(8)
        })
    }

    @objc
    func likeTapped(_ sender: UIButton) {
        if sender.isSelected {
            likeButton.setImage(
                UIImage(systemName: "heart")?.withTintColor(
                    UIColor(hex: "#F18EF0"),
                    renderingMode: .alwaysOriginal
                ).resized(to: CGSize(width: 30, height: 25)),
                for: .normal
            )
            print("Unlike tapped!")
        } else {
            likeButton.setImage(
                UIImage(systemName: "heart.fill")?.withTintColor(
                    UIColor(hex: "#F18EF0"),
                    renderingMode: .alwaysOriginal
                ).resized(to: CGSize(width: 30, height: 25)),
                for: .normal
            )
            print("Like tapped!")
        }
        sender.isSelected.toggle()
    }
}

extension RecommendationCell: Configurable, Reusable {
    typealias DataType = MyEventsModel
    
    func configure(with model: DataType) {
        imageView.image = model.image
        title.text = model.name
        dayLabel.text = model.date
        timeLabel.text = model.time
        audienceLabel.text = model.location
    }
}
