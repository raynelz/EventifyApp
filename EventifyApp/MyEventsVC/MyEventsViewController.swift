//
//  MyEventsViewController.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 18.03.2024.
//

import UIKit
import SnapKit

final class MyEventsViewController: UIViewController {
    let sectionTitle = ["Предстоящие мероприятия", "Ждут оценки"]
    var sections: [Section] = []

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 108)
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 50)
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 28, right: 0)
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
        configureSections()
    }

    private func setupViews() {
        title = "Мои ивенты"
        navigationController?.addCustomBottomLine(color: .white, height: 1.0)
        view.backgroundColor = UIColor(hex: "#161618")
        view.addSubview(collectionView)
    }

    private func setupCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(EventsViewCell.self, forCellWithReuseIdentifier: EventsViewCell.cellId)
        collectionView.register(
            SectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeader.headerId
        )
    }

    private func setupLayout() {
        collectionView.snp.makeConstraints({
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        })
    }

    private func configureSections() {
        sections = [
            .upcoming(
                [
                    EventsModel(
                        title: "День открытых дверей",
                        day: "25 марта",
                        time: "17:30",
                        audience: "Б-3",
                        color: "#F18EF0",
                        qrCode: UIImage(named: "qr")
                    ),
                    EventsModel(
                        title: "Волейбол: МИСИС Vs МФТИ",
                        day: "12 марта",
                        time: "14:30",
                        audience: "Горный",
                        color: "#DDF14A",
                        qrCode: UIImage(named: "qr")
                    ),
                    EventsModel(
                        title: "Swift Meetup",
                        day: "14 марта",
                        time: "18:00",
                        audience: "Онлайн",
                        color: "#F18EF0",
                        qrCode: UIImage(named: "qr")
                    )
                ]
            ),
            .wait(
                [
                    EventsModel(
                        title: "Баскетбол: МИСИС Vs МФТИ",
                        day: "12 марта",
                        time: "14:30",
                        audience: "Горный",
                        color: "#F18EF0",
                        qrCode: UIImage(named: "qr")
                    ),
                    EventsModel(
                        title: "Hackaton Meetup",
                        day: "14 марта",
                        time: "18:00",
                        audience: "Онлайн",
                        color: "#DDF14A",
                        qrCode: UIImage(named: "qr")
                    ),
                    EventsModel(
                        title: "Баскетбол: МИСИС Vs МФТИ",
                        day: "12 марта",
                        time: "14:30",
                        audience: "Горный",
                        color: "#F18EF0",
                        qrCode: UIImage(named: "qr")
                    ),
                    EventsModel(
                        title: "Hackaton Meetup",
                        day: "14 марта",
                        time: "18:00",
                        audience: "Онлайн",
                        color: "#DDF14A",
                        qrCode: UIImage(named: "qr")
                    )
                ]
            )
        ]
    }
}

extension MyEventsViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = EventCardViewController()
        if indexPath.row == 0 {
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

extension MyEventsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: EventsViewCell.cellId,
            for: indexPath
        ) as? EventsViewCell  else { return UICollectionViewCell() }

        let item = sections[indexPath.section].items[indexPath.row]
        cell.configureCell(model: item)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SectionHeader.headerId,
            for: indexPath
        ) as? SectionHeader else { return UICollectionReusableView() }
        header.configure(with: sectionTitle[indexPath.section])
        return header
    }
}
