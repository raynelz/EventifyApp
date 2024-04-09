//
//  FavoritesViewController.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 09.04.2024.
//

import UIKit
import SnapKit

final class FavoritesViewController: UIViewController {
    let segmentItems = ["Ивенты", "Организаторы"]

    let data: [FavouritesEventModel] = [
        FavouritesEventModel(
            image: UIImage(named: "eventIcon2"),
            title: "День открытых дверей университета МИСИС",
            day: "12 декабря",
            time: "17:30",
            audience: "онлайн"
        ),
        FavouritesEventModel(
            image: UIImage(named: "eventIcon"),
            title: "Ярмарка вакансий",
            day: "21 марта",
            time: "10:00-17:00",
            audience: "Б-корпус"
        ),
        FavouritesEventModel(
            image: UIImage(named: "eventIcon3"),
            title: "Весенняя серия турнира «Что? Где? Когда?»",
            day: "27 марта",
            time: "18:00",
            audience: "К-111"
        )
    ]

    private lazy var segmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: segmentItems)
        control.selectedSegmentTintColor = UIColor(hex: "#161618")
        control.selectedSegmentIndex = 0
        return control
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        layout.itemSize = CGSize(width: 195, height: 248)
        layout.estimatedItemSize = CGSize(width: 195, height: 248)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        setupCollection()
    }

    private func setupViews() {
        view.backgroundColor = UIColor(hex: "#161618")
        navigationController?.addCustomBottomLine(color: UIColor(hex: "#858591"), height: 1)
        title = "Избранное"
        view.addSubviews(segmentControl, collectionView)
    }

    private func setupLayout() {
        segmentControl.snp.makeConstraints({
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
        })

        collectionView.snp.makeConstraints({
            $0.top.equalTo(segmentControl.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        })
    }

    private func setupCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(EventsItemsCell.self, forCellWithReuseIdentifier: EventsItemsCell.cellId)
    }
}

extension FavoritesViewController: UICollectionViewDelegate {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
//    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: EventsItemsCell.cellId,
            for: indexPath
        ) as? EventsItemsCell else { return UICollectionViewCell() }
        cell.configureCell(with: data[indexPath.row])
        return cell
    }

}
