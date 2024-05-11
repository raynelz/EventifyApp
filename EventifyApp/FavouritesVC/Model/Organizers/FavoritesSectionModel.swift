//
//  FavoritesOrganizersSectionModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 28.04.2024.
//

import UIKit

enum FavoritesSectionModel {
    case favorites([MyEventsModel])
    case recommendations([MyEventsModel])
    case empty(EmptyContent)

    var items: [MyEventsModel] {
        switch self {
        case .favorites(let items),
                .recommendations(let items):
            return items
        case .empty: return []
        }
    }

    var count: Int {
        items.count
    }

    var title: String {
        switch self {
        case .favorites(_):
            return ""
        case .recommendations(_):
            return "Рекомендации"
        case .empty:
            return ""
        }
    }
}

extension FavoritesSectionModel {
    func makeLayout() -> NSCollectionLayoutSection {
        switch self {
        case .favorites(let favoritesEvents):
            if favoritesEvents.isEmpty {
                return createEmptySection()
            } else {
                return createFavoritesSection()
            }
        case .recommendations:
            return createRecommendationSection()
        case .empty:
            return createEmptySection()
        }
    }
}

private extension FavoritesSectionModel {
    func createLayoutSection(
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

    func createFavoritesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(280))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(280))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8

        return section
    }

    func createRecommendationSection() -> NSCollectionLayoutSection {
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

    func createEmptySection() -> NSCollectionLayoutSection {
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
