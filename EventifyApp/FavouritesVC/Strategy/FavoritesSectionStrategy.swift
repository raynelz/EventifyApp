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
        case .favorites(let favorites):
            collectionView.createCellForItems(
                favorites,
                emptyCellType: NoEventsCell.self,
                cellType: FavoritesCell.self,
                at: indexPath
            )
        case .recommendations(let recommendations):
            collectionView.createCellForItems(recommendations, cellType: FavoritesRecommendationCell.self, at: indexPath)
        case .empty:
            collectionView.createCellForItems([], cellType: NoEventsCell.self, at: indexPath)
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
        case .favorites(let favorites):
            collectionView.createCellForItems(
                favorites,
                emptyCellType: NoFavoritesOrganizersCell.self,
                cellType: OrganizerCell.self,
                at: indexPath
            )
        case .recommendations(let recommendations):
            collectionView.createCellForItems(recommendations, cellType: OrganizersRecommendationCell.self, at: indexPath)
        case .empty:
            collectionView.createCellForItems([], cellType: NoFavoritesOrganizersCell.self, at: indexPath)
        }
    }
    
    func countOfSections() -> Int {
        items.count
    }

    func countOfItems() -> Int {
        return max(1, items.count)
    }
}
