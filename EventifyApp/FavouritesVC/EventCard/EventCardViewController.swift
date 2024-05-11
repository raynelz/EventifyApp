//
//  registrationCardViewController.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.05.2024.
//

import SnapKit
import UIKit

final class EventCardViewController: UIViewController {
    let images = [UIImage(named: "eventIcon2")!, UIImage(named: "eventIcon2")!, UIImage(named: "eventIcon2")!]
    private var currentPage = 0

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false

        collection.register(CarouselViewCell.self, forCellWithReuseIdentifier: CarouselViewCell.cellId)
        collection.dataSource = self
        collection.delegate = self
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true

        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 248)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        return collection
    }()

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.numberOfPages = images.count
        pageControl.currentPage = currentPage
        pageControl.numberOfPages = images.count
        pageControl.isHidden = pageControl.numberOfPages == 1
        pageControl.addTarget(self, action: #selector(pageControlSelectionAction), for: .touchUpInside)
        return pageControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavBar()
        setupLayout()
    }

    // MARK: - Setup Views

    private func setupViews() {
        view.backgroundColor = .mainBackground
        view.addSubviews(
            collectionView,
            pageControl
        )
    }

    // MARK: - Setup Layout

    private func setupLayout() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(248)
        }

        pageControl.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
    }

    // MARK: - Setup Navigation Bar

    private func setupNavBar() {
        navigationController?.navigationBar.tintColor = .gray
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.removeCustomBottomLine()

        let likeRightButton = createCustomButton(
            imageName: "heart",
            selector: #selector(likeTapped),
            tintColor: .brandPink
        )
        let shareRightButton = createCustomButton(
            imageName: "arrowshape.turn.up.right",
            selector: #selector(shareTapped),
            tintColor: .gray
        )

        let customTitleView = createCustomTitleView(
            eventName: "День открытых дверей\nуниверситета МИСИС"
        )

        navigationItem.rightBarButtonItems = [shareRightButton, likeRightButton]
        navigationItem.titleView = customTitleView
    }

    @objc
    private func likeTapped() {
        print("Like Tapped!!!")
    }

    @objc
    private func shareTapped() {
        print("Share Tapped!!!")
    }

    @objc
    private func pageControlSelectionAction(_ sender: UIPageControl) {
        let page = sender.currentPage
        let contentOffsetX = collectionView.bounds.width * CGFloat(page)
        collectionView.setContentOffset(CGPoint(x: contentOffsetX, y: 0), animated: true)
    }
}

extension EventCardViewController: UICollectionViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentIndex = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        guard pageControl.currentPage != currentIndex else { return }
        pageControl.currentPage = currentIndex
    }
}

extension EventCardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.createCellForItems(
            images,
            cellType: CarouselViewCell.self,
            at: indexPath
        )

        return cell
    }
}
