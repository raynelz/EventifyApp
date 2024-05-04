//
//  ViewController.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 13.03.2024.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "IN WORK!"
        label.textColor = .label
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
    }

    private func setupViews() {
        view.backgroundColor = .mainBackground
        view.addSubview(textLabel)
    }

    private func setupLayout() {
        textLabel.snp.makeConstraints({
            $0.center.equalToSuperview()
        })
    }

    @objc
    private func logOut(_ sender: UIButton) {
        AuthService.shared.logOut { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
