//
//  ProfileViewController.swift
//  EventifyApp
//
//  Created by Рассказов Глеб on 02.05.2024.
//

import UIKit
import SnapKit

final class ProfileViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self)
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = ProfileHeaderView()
        return tableView
    }()

    private let profileItems: [[ProfileSection]] = [
        [
            .item("Добавить мероприятие"),
        ],
        [
            .item("Уведомления"),
            .item("Помощь и поддержка"),
        ],
        [
            .item("О приложении"),
            .item("Оценить"),
        ],
        [
            .item("Выйти", isHasDisclosure: false),
        ],
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        view.backgroundColor = .background

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        profileItems.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileItems[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: UITableViewCell.self, for: indexPath)
        let item = profileItems[indexPath.section][indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.hasDisclosure ? .disclosureIndicator : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 20))
            header.backgroundColor = .clear
            return header
        }
        return nil
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
