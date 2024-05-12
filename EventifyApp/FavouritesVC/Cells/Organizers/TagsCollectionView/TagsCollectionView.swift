//
//  TagsCollecitonView.swift
//  EventifyApp
//
//  Created by Рассказов Глеб on 04.05.2024.
//

import UIKit

final class TagsCollectionView: UICollectionView {
    var items: [TagsModel] {
        didSet {
            reloadData()
        }
    }

    init(items: [TagsModel]) {
        self.items = items

        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        layout.sectionInset = .zero

        super.init(frame: .zero, collectionViewLayout: layout)

        self.backgroundColor = .clear
        register(TagCollectionViewCell.self)
        self.dataSource = self
        self.delegate = self
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TagsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        return collectionView.createCellForItems(
            items,
            cellType: TagCollectionViewCell.self,
            at: indexPath
        )
    }
}

extension TagsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.text = items[indexPath.row].text
        label.sizeToFit()

        return CGSize(width: label.frame.width + 16, height: label.frame.height + 4)
    }
}
