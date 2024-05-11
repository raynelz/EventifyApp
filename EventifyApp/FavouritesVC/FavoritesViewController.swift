//
//  FavoritesViewController.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 09.04.2024.
//

import SnapKit
import UIKit

final class FavoritesViewController: UIViewController {
    private let favoritesEventsData = FavoritesEventsMockData.shared.favoritesPageData
    private let favoritesOrganizersData = FavoritesOrganizersMockData.shared.organizersPageData
    private let segmentItems = ["Ивенты", "Организаторы"]
    
    private lazy var segmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: segmentItems)
        control.selectedSegmentTintColor = .mainBackground
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        return control
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.bounces = true
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    private var currentItems: [FavoritesSectionModel] {
        segmentControl.selectedSegmentIndex == 0 ? favoritesEventsData : favoritesOrganizersData
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupLayout()
        setupCollection()
    }

    private func setupViews() {
        title = "Избранное"
        navigationController?.addCustomBottomLine(color: .navigationLine, height: 1.0)

        view.backgroundColor = .mainBackground
        view.addSubviews(segmentControl, collectionView)
    }

    private func setupLayout() {
        segmentControl.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    private func setupCollection() {
        collectionView.dataSource = self
        collectionView.register(RecommendationCell.self)
        collectionView.register(EmptyCell.self)
        collectionView.registerHeader(HeaderSupplementaryView.self)
        collectionView.collectionViewLayout = createLayout()
    }
    
    @objc
    private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        collectionView.reloadData()
    }
}

extension FavoritesViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            return self.favoritesEventsData[sectionIndex].makeLayout()
        }
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        currentItems.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currentItems[section].count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch currentItems[indexPath.section] {
        case .favorites(let data), .recommendations(let data):
            let cell = collectionView.dequeueReusableCell(RecommendationCell.self, for: indexPath)
            cell.configure(with: data[indexPath.row])
            cell.configureLayout(for: segmentControl.selectedSegmentIndex == 0 ? .event : .organizer)
            return cell
        case .empty(let data):
            return collectionView.createCellForItems(
                [data],
                cellType: EmptyCell.self,
                at: indexPath
            )
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let cell = collectionView.dequeueHeader(HeaderSupplementaryView.self, for: indexPath)
            cell.configure(categoryName: favoritesEventsData[indexPath.section].title)
            return cell
        default:
            return UICollectionReusableView()
        }
    }
}
