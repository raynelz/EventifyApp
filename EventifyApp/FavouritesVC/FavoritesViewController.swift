//
//  FavoritesViewController.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 09.04.2024.
//

import UIKit
import SnapKit

final class FavoritesViewController: UIViewController {
    private let favoritesEventsData = FavoritesEventsMockData.shared.favoritesPageData
    private let favoritesOrganizersData = FavoritesOrganizersMockData.shared.organizersPageData
    private let segmentItems = ["Ивенты", "Организаторы"]

    private lazy var segmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: segmentItems)
        control.selectedSegmentTintColor = UIColor(hex: "#161618")
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        return control
    }()

    @objc
    private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        collectionView.reloadData()
    }

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
        setupViews()
        setupLayout()
        setupCollection()
    }

    private func setupViews() {
        title = "Избранное"
        view.backgroundColor = UIColor(hex: "#161618")
        navigationController?.addCustomBottomLine(color: UIColor(hex: "#858591"), height: 1.0)
        view.addSubviews(segmentControl, collectionView)
    }

    private func setupLayout() {
        segmentControl.snp.makeConstraints({
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
        })

        collectionView.snp.makeConstraints({
            $0.top.equalTo(segmentControl.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        })
    }

    private func setupCollection() {
        collectionView.dataSource = self
        collectionView.register(FavoritesCell.self, forCellWithReuseIdentifier: FavoritesCell.cellId)
        collectionView.register(
            FavoritesRecommendationCell.self,
            forCellWithReuseIdentifier: FavoritesRecommendationCell.cellId
        )
        collectionView.register(NoFavoritesCell.self, forCellWithReuseIdentifier: NoFavoritesCell.cellId)
        collectionView.register(OrganizerCell.self, forCellWithReuseIdentifier: OrganizerCell.cellId)
        collectionView.register(
            NoFavoritesOrganizersCell.self,
            forCellWithReuseIdentifier: NoFavoritesOrganizersCell.cellId
        )
        collectionView.register(
            OrganizersRecommendationCell.self,
            forCellWithReuseIdentifier: OrganizersRecommendationCell.cellId
        )
        collectionView.register(
            HeaderSupplementaryView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderSupplementaryView.headerId
        )
        collectionView.collectionViewLayout = createLayout()
    }
}

extension FavoritesViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            let section = self.favoritesEventsData[sectionIndex]
            switch section {
            case .favorites(let favoritesEvents):
                if favoritesEvents.isEmpty {
                    return self.createEmptySection()
                } else {
                    return self.createFavoritesSection()
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

    private func createFavoritesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(280))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(280))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8

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

extension FavoritesViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return segmentControl.selectedSegmentIndex == 0 ? favoritesEventsData.count : favoritesOrganizersData.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if segmentControl.selectedSegmentIndex == 0 {
            switch favoritesEventsData[section] {
            case .favorites(let favoritesEvents):
                return favoritesEvents.isEmpty ? 1 : favoritesEvents.count
            case .recommendations(let recommendations):
                return recommendations.count
            case .empty:
                return 1
            }
        } else {
            switch favoritesOrganizersData[section] {
            case .favorites(let favoritesEvents):
                return favoritesEvents.isEmpty ? 1 : favoritesEvents.count
            case .recommendations(let recommendations):
                return recommendations.count
            case .empty:
                return 1
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if segmentControl.selectedSegmentIndex == 0 {
            switch favoritesEventsData[indexPath.section] {
            case let .favorites(favorites):
                if favorites.isEmpty {
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: NoFavoritesCell.cellId,
                        for: indexPath
                    ) as? NoFavoritesCell else { return UICollectionViewCell() }
                    return cell
                } else {
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: FavoritesCell.cellId,
                        for: indexPath
                    ) as? FavoritesCell else { return UICollectionViewCell() }
                    cell.configureCell(with: favorites[indexPath.row])
                    return cell
                }
            case let .recommendations(recommendations):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FavoritesRecommendationCell.cellId,
                    for: indexPath
                ) as? FavoritesRecommendationCell else { return UICollectionViewCell() }

                cell.configureCell(with: recommendations[indexPath.row])
                return cell
            case .empty:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: NoEventsCell.cellId,
                    for: indexPath
                ) as? NoEventsCell else { return UICollectionViewCell() }
                return cell
            }
        } else {
            switch favoritesOrganizersData[indexPath.section] {
            case let .favorites(favorites):
                if favorites.isEmpty {
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: NoFavoritesOrganizersCell.cellId,
                        for: indexPath
                    ) as? NoFavoritesOrganizersCell else { return UICollectionViewCell() }
                    return cell
                } else {
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrganizerCell.cellId, for: indexPath) as? OrganizerCell else { return UICollectionViewCell() }
                    cell.configureCell(with: favorites[indexPath.row])
                    return cell
                }
            case let .recommendations(recommendations):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: OrganizersRecommendationCell.cellId,
                    for: indexPath
                ) as? OrganizersRecommendationCell else { return UICollectionViewCell() }
                cell.configureCell(with: recommendations[indexPath.row])
                return cell
            case .empty:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: NoFavoritesOrganizersCell.cellId,
                    for: indexPath
                ) as? NoFavoritesOrganizersCell else { return UICollectionViewCell() }
                return cell
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let cell = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderSupplementaryView.headerId,
                for: indexPath
            ) as? HeaderSupplementaryView else { return UICollectionReusableView() }
            cell.configurateHeader(categoryName: favoritesEventsData[indexPath.section].title)
            return cell
        default:
            return UICollectionReusableView()
        }
    }
}
