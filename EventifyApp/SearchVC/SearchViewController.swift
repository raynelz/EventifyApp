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

    let students = SearchMockData.shared.studentsData
    let abiturients = SearchMockData.shared.abiturientsData

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
        control.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        return control
    }()

    @objc
    private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        collectionView.reloadData()
    }

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
        navigationController?.addCustomBottomLine(color: UIColor(hex: "#858591"), height: 1)
        title = "Поиск"
        view.backgroundColor = UIColor(hex: "#161618")
        view.addSubviews(searchBar, segmentControl, collectionView)
    }

    private func setupCollection() {
        collectionView.dataSource = self
        collectionView.register(CategoriesCollectionViewCell.self)
    }

    private func setupLayout() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
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

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return segmentControl.selectedSegmentIndex == 0 ? students.count : abiturients.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let currentModel = segmentControl.selectedSegmentIndex == 0 ? students : abiturients
        
        return collectionView.createCellForItems(
            currentModel,
            cellType: CategoriesCollectionViewCell.self,
            at: indexPath
        )
    }
}
