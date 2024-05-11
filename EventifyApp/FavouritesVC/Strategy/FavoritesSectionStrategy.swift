//
//  FavoritesSectionStrategy.swift
//  EventifyApp
//
//  Created by Рассказов Глеб on 02.05.2024.
//

import UIKit

protocol FavoritesSectionStrategy {
    func cellForItem(at indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell
    func countOfSections() -> Int
    func countOfItems() -> Int
}

class EventsStrategy: FavoritesSectionStrategy {
    private var items: [FavoritesSectionModel]

    init(items: [FavoritesSectionModel]) {
        self.items = items
    }

    func cellForItem(at indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        switch items[indexPath.section] {
        case .favorites(let data), .recommendations(let data):
            let cell = collectionView.dequeueReusableCell(RecommendationCell.self, for: indexPath)
            cell.configure(with: data[indexPath.row])
            cell.configureLayout(for: .event)
            return cell
        case .empty:
            return collectionView.createCellForItems([], cellType: NoEventsCell.self, at: indexPath)
        }
    }

    func countOfSections() -> Int {
        items.count
    }

    func countOfItems() -> Int {
        return max(1, items.count)
    }
}

class OrganizersStrategy: FavoritesSectionStrategy {
    private var items: [FavoritesSectionModel]

    init(items: [FavoritesSectionModel]) {
        self.items = items
    }

    func cellForItem(at indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        switch items[indexPath.section] {
        case .favorites(let data), .recommendations(let data):
            let cell = collectionView.dequeueReusableCell(RecommendationCell.self, for: indexPath)
            cell.configure(with: data[indexPath.row])
            cell.configureLayout(for: .organizer)
            return cell
        case .empty:
            return collectionView.createCellForItems(
                [],
                cellType: NoFavoritesOrganizersCell.self,
                at: indexPath
            )
        }
    }

    func countOfSections() -> Int {
        items.count
    }

    func countOfItems() -> Int {
        return max(1, items.count)
    }
}
