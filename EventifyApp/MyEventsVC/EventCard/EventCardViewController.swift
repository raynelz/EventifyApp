//
//  EventCardViewController.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 02.04.2024.
//

import UIKit
import SnapKit

final class EventCardViewController: UIViewController {

    let data = [
        DetailModel(id: 1, title: "2 марта"),
        DetailModel(id: 2, title: "17:30"),
        DetailModel(id: 3, title: "Б-3")
    ]

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

    private lazy var detailsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        return collection
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        // swiftlint: disable all
        label.text = "Дни открытых дверей — это уникальная возможность для старшеклассников больше узнать о специальностях, которым обучают в одном из лучших технических университетов России."
        // swiftlint: enable all
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()

    private lazy var linkButton: UIButton = {
        let button = UIButton()
        button.setTitle("Перейти к странице мероприятия", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.setImage(
            UIImage(systemName: "chevron.right")?.withTintColor(
                UIColor(hex: "#DDF14A"),
                renderingMode: .alwaysOriginal
            ),
            for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.setTitleColor(UIColor(hex: "#DDF14A"), for: .normal)
        button.addTarget(self, action: #selector(linkTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        configureCollection()
    }

    private func setupViews() {
        view.backgroundColor = UIColor(hex: "#161618")
        view.addSubviews(
            qrImageView,
            divider,
            typeOfEventLabel,
            titleLabel,
            detailsCollectionView,
            descriptionLabel,
            linkButton
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
        
        detailsCollectionView.snp.makeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        })

        descriptionLabel.snp.makeConstraints({
            $0.top.equalTo(detailsCollectionView.snp.bottom).offset(28)
            $0.horizontalEdges.equalToSuperview().inset(16)
        })

        linkButton.snp.makeConstraints({
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        })
    }

    private func configureCollection() {
        detailsCollectionView.delegate = self
        detailsCollectionView.dataSource = self
        detailsCollectionView.register(DetailsItemCell.self)
    }

    @objc
    func linkTapped(_ sender: UIButton) {
        if let url = URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ") {
            UIApplication.shared.open(url)
        }
    }
}

extension EventCardViewController: UICollectionViewDelegate {

}

extension EventCardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(DetailsItemCell.self, for: indexPath)
        cell.configure(with: data[indexPath.row])
        return cell
    }

}
