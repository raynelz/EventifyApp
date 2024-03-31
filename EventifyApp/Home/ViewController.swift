//
//  ViewController.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 13.03.2024.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
    }

    private func setupViews() {
        view.backgroundColor = UIColor(hex: "#161618")
        view.addSubview(logOutButton)
    }

    private func setupLayout() {
        logOutButton.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.size.equalTo(80)
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
