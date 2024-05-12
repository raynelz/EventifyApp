//
//  UIViewController+CustomNav.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.05.2024.
//

import UIKit

extension UIViewController {
    func createCustomTitleView(eventName: String) -> UIView {
        let view = UIView()
        view.backgroundColor = .mainBackground
        view.translatesAutoresizingMaskIntoConstraints = false

        guard let navigationBar = navigationController?.navigationBar else {
            return view
        }

        navigationBar.addSubview(view)

        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor),
            view.topAnchor.constraint(equalTo: navigationBar.topAnchor),
            view.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor)
        ])

        let eventTitle = UILabel()
        eventTitle.text = eventName
        eventTitle.textAlignment = .center
        eventTitle.font = .systemFont(ofSize: 20, weight: .semibold)
        eventTitle.numberOfLines = 2
        eventTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(eventTitle)

        NSLayoutConstraint.activate([
            eventTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            eventTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        return view
    }

    func createCustomButton(
        imageName: String,
        selector: Selector,
        tintColor: UIColor
    ) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(
            UIImage(systemName: imageName),
            for: .normal
        )
        button.tintColor = tintColor
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: selector, for: .touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
}
