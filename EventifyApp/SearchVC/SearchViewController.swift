//
//  SearchViewController.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 18.03.2024.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {

    let segmentItems = ["Для студентов", "Для поступающих"]
    let categoriesItems = [
        CategoriesModel(title: "Спорт", image: UIImage(named: "sport"), color: "#A4473F"),
        CategoriesModel(title: "Наука", image: UIImage(named: "science"), color: "#073B8F"),
        CategoriesModel(title: "ITAM", image: UIImage(named: "itam"), color: "#000000")
    ]

    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.searchBarStyle = .minimal
        search.placeholder = "Поиск"
        return search
    }()

    private lazy var segmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: segmentItems)
        control.selectedSegmentTintColor = UIColor(hex: "#161618")
        control.selectedSegmentIndex = 0
        return control
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 160)
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        setupCollection()
    }

    private func setupViews() {
        title = "Поиск"
        view.backgroundColor = UIColor(hex: "#161618")
        [searchBar, segmentControl, collectionView].forEach({ view.addSubview($0) })
    }

    private func setupCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: "categoriesCell")
    }

    private func setupLayout() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.horizontalEdges.equalToSuperview()
        }

        segmentControl.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(8)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension SearchViewController: UICollectionViewDelegate {
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesItems.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "categoriesCell",
            for: indexPath
        ) as? CategoriesCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(model: categoriesItems[indexPath.row])
        return cell
    }

}
