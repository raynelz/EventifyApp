//
//  MyEventsViewController.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 18.03.2024.
//

import UIKit
import SnapKit

final class MyEventsViewController: UIViewController {

    let eventsItems = [EventsModel(title: "День открытых дверей", day: "2 марта", time: "17:30", audience: "Б-3", color: "#F18EF0", qrCode: UIImage(named: "qr")), EventsModel(title: "День открытых дверей", day: "2 марта", time: "17:30", audience: "Б-3", color: "#DDF14A", qrCode: UIImage(named: "qr")), EventsModel(title: "День открытых дверей", day: "2 марта", time: "17:30", audience: "Б-3", color: "#F18EF0", qrCode: UIImage(named: "qr"))]

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 108)
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCollection()
        setupLayout()
    }

    private func setupViews() {
        title = "Мои ивенты"
        view.backgroundColor = UIColor(hex: "#161618")
        view.addSubview(collectionView)
    }

    private func setupCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(EventsViewCell.self, forCellWithReuseIdentifier: "eventsCell")
    }

    private func setupLayout() {
        collectionView.snp.makeConstraints({
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        })
    }


}

extension MyEventsViewController: UICollectionViewDelegate {
}

extension MyEventsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventsItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventsCell", for: indexPath) as? EventsViewCell  else { return UICollectionViewCell() }
        cell.configureCell(model: eventsItems[indexPath.row])
        return cell
    }
    

}
