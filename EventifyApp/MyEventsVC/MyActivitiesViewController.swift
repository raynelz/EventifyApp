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
        navigationController?.addCustomBottomLine(color: UIColor(hex: "#858591"), height: 1.0)
        view.backgroundColor = UIColor(hex: "#161618")
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
            let section = self.sections[sectionIndex]
            switch section {
            case .upcoming(let upcomingEvents):
                if upcomingEvents.isEmpty {
                    return self.createEmptySection()
                } else {
                    return self.createUpcomingSection()
                }
            case .recommendations:
                return self.createRecommendationSection()
            case .empty:
                return self.createEmptySection()
            }
        }
    }

    private func createLayoutSection(
        group: NSCollectionLayoutGroup,
        behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
        interGroupSpacing: CGFloat,
        supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem],
        contentInsets: Bool
    ) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpacing
        section.boundarySupplementaryItems = supplementaryItems
        section.supplementariesFollowContentInsets = contentInsets
        return section
    }

    private func createUpcomingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(112.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(112))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )

        let section = createLayoutSection(
            group: group,
            behavior: .none,
            interGroupSpacing: 8,
            supplementaryItems: [header],
            contentInsets: false
        )
        return section
    }

    private func createRecommendationSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(280))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.65), heightDimension: .estimated(280))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 0)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(66))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )

        let section = createLayoutSection(
            group: group,
            behavior: .continuous,
            interGroupSpacing: 16,
            supplementaryItems: [header],
            contentInsets: false
        )
        return section
    }

    private func createEmptySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.interGroupSpacing = 0
        section.boundarySupplementaryItems = []
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        return section
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

    // TODO: Сделать с extensions домашнее задание захару
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case let .upcoming(upcoming):
            if upcoming.isEmpty {
                let cell = collectionView.dequeueReusableCell(NoEventsCell.self, for: indexPath)
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(EventCell.self, for: indexPath)
                cell.configure(with: upcoming[indexPath.row])
                return cell
            }
        case let .recommendations(recommendations):
            let cell = collectionView.dequeueReusableCell(RecommendationCell.self, for: indexPath)
            cell.configure(with: recommendations[indexPath.row])
            return cell
        case .empty:
            let cell = collectionView.dequeueReusableCell(NoEventsCell.self, for: indexPath)
            return cell
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
