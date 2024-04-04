//
//  EventCardViewController.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 02.04.2024.
//

import UIKit
import SnapKit

final class EventCardViewController: UIViewController {

    let containers = [
        DetailsView() : DetailModel(id: 1,title: "2 марта"),
        DetailsView() : DetailModel(id: 2,title: "17:30"),
        DetailsView() : DetailModel(id: 3,title: "Б-3")
    ].sorted { $0.value.id < $1.value.id }

    private lazy var qrImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "qrCard")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var divider: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private lazy var typeOfEventLabel: UILabel = {
        let label = UILabel()
        label.text = "Экскурсия"
        label.textColor = UIColor(hex: "#858591")
        label.font = .systemFont(ofSize: 17, weight: .light)
        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "День открытых дверей"
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .medium)
        return label
    }()

    private lazy var detailsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 12
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        setupContainers()
        setupContainersData()
    }

    private func setupViews() {
        view.backgroundColor = UIColor(hex: "#161618")
        view.addSubviews(
            qrImageView,
            divider,
            typeOfEventLabel,
            titleLabel,
            detailsStackView
        )
    }

    private func setupLayout() {
        qrImageView.snp.makeConstraints({
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(65)
        })

        divider.snp.makeConstraints({
            $0.top.equalTo(qrImageView.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        })

        typeOfEventLabel.snp.makeConstraints({
            $0.top.equalTo(divider.snp.top).offset(16)
            $0.leading.equalToSuperview().offset(16)
        })

        titleLabel.snp.makeConstraints({
            $0.top.equalTo(typeOfEventLabel.snp.bottom).offset(4)
            $0.leading.equalTo(typeOfEventLabel.snp.leading)
        })
        
        detailsStackView.snp.makeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
        })
    }

    func setupContainers() {
        containers.forEach { view, _ in
            detailsStackView.addArrangedSubview(view)
        }
    }

    func setupContainersData() {
        containers.forEach { view, model in
            view.setText(with: model)
        }
    }
}
