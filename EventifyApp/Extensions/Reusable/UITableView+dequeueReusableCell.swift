//
//  UITableView+dequeueReusableCell.swift
//  EventifyApp
//
//  Created by Рассказов Глеб on 02.05.2024.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell & Reusable>(_ cellClass: T.Type) {
        self.register(cellClass, forCellWithReuseIdentifier: cellClass.id)
    }

    func dequeueReusableCell<T: UICollectionViewCell & Reusable>(
        _ cellType: T.Type,
        for indexPath: IndexPath
    ) -> T {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: cellType.id,
            for: indexPath
        ) as? T else {
            fatalError("Unable to dequeue reusable cell with identifier \(cellType.id) for \(cellType)")
        }
        return cell
    }

    func registerHeader<T: UICollectionReusableView & Reusable>(_ viewType: T.Type) {
        self.register(
            viewType,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: viewType.id
        )
    }

    func registerFooter<T: UICollectionReusableView & Reusable>(_ viewType: T.Type) {
        self.register(
            viewType,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: viewType.id
        )
    }

    func dequeueHeader<T: UICollectionReusableView & Reusable>(
        _ viewType: T.Type,
        for indexPath: IndexPath
    ) -> T {
        guard let header = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: viewType.id,
            for: indexPath
        ) as? T else {
            fatalError("Unable to dequeue header of type \(viewType) with identifier \(viewType.id)")
        }
        return header
    }

    func dequeueFooter<T: UICollectionReusableView & Reusable>(_ viewType: T.Type, for indexPath: IndexPath) -> T {
        guard let footer = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: viewType.id,
            for: indexPath
        ) as? T else {
            fatalError("Unable to dequeue footer of type \(viewType) with identifier \(viewType.id)")
        }
        return footer
    }

    func createCellForItems<
        SomeCell: UICollectionViewCell & Configurable & Reusable,
        EmptyCell: UICollectionViewCell & Reusable
    >(
        _ items: [SomeCell.DataType],
        emptyCellType: EmptyCell.Type,
        cellType: SomeCell.Type,
        at indexPath: IndexPath
    ) -> UICollectionViewCell {
        if items.isEmpty {
            return dequeueReusableCell(emptyCellType.self, for: indexPath)
        } else {
            let cell = dequeueReusableCell(cellType.self, for: indexPath)
            cell.configure(with: items[indexPath.row])
            return cell
        }
    }

    func createCellForItems<
        SomeCell: UICollectionViewCell & Configurable & Reusable
    >(
        _ items: [SomeCell.DataType],
        cellType: SomeCell.Type,
        at indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = dequeueReusableCell(cellType.self, for: indexPath)
        cell.configure(with: items[indexPath.row])
        return cell
    }
}

extension UITableView {
    func register<T: UITableViewCell & Reusable>(_ cellClass: T.Type) {
        self.register(cellClass, forCellReuseIdentifier: cellClass.id)
    }

    func dequeueReusableCell<T: UITableViewCell & Reusable>(
        with cellType: T.Type,
        for indexPath: IndexPath
    ) -> T {
        guard let cell = dequeueReusableCell(
            withIdentifier: cellType.id,
            for: indexPath
        ) as? T else {
            fatalError("Unable to dequeue reusable cell with identifier \(cellType.id) for \(cellType)")
        }
        return cell
    }

    func registerHeaderFooterView<T: UITableViewHeaderFooterView & Reusable>(_ viewType: T.Type) {
        self.register(viewType, forHeaderFooterViewReuseIdentifier: viewType.id)
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView & Reusable>(with cellType: T.Type) -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: cellType.id) as? T else {
            fatalError("Unable to dequeue header or footer with identifier \(T.id)")
        }
        return view
    }
}
