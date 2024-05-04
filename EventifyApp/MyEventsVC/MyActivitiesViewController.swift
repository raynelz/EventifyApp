//
//  MyActivitiesViewController.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 26.04.2024.
//
import SnapKit
import UIKit

final class MyActivitiesViewController: UIViewController {
    private let sections = MyEventsMockData.shared.pageData

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.bounces = true
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        setupCollection()
    }

    private func setupView() {
        title = "Мои ивенты"
        navigationController?.addCustomBottomLine(color: .navigationLine, height: 1.0)
        view.backgroundColor = .mainBackground
        view.addSubview(collectionView)
    }

    private func setupLayout() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.snp.topMargin)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.snp.bottomMargin)
        }
    }

    private func setupCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(EventCell.self)
        collectionView.register(RecommendationCell.self)
        collectionView.register(NoEventsCell.self)
        collectionView.registerHeader(HeaderSupplementaryView.self)

        collectionView.collectionViewLayout = createLayout()
    }
}

extension MyActivitiesViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            return self.sections[sectionIndex].makeLayout()
        }
    }
}

extension MyActivitiesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = EventCardViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension MyActivitiesViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
        case .upcoming(let upcomingEvents):
            return upcomingEvents.isEmpty ? 1 : upcomingEvents.count
        case .recommendations(let recommendations):
            return recommendations.count
        case .empty:
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case let .upcoming(upcoming):
            return collectionView.createCellForItems(
                upcoming,
                emptyCellType: NoEventsCell.self,
                cellType: EventCell.self,
                at: indexPath
            )
        case let .recommendations(recommendations):
            return collectionView.createCellForItems(
                recommendations,
                cellType: RecommendationCell.self,
                at: indexPath
            )
        case .empty:
            return collectionView.createCellForItems(
                [],
                cellType: NoEventsCell.self,
                at: indexPath
            )
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueHeader(HeaderSupplementaryView.self, for: indexPath)
            header.configure(categoryName: sections[indexPath.section].title)
            return header
        default:
            return UICollectionReusableView()
        }
    }
}
