//
//  ViewController.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 13.03.2024.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
    let testLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        embedViews()
        setupLayout()
        setupAppearance()
        setupBehavior()
    }
}

private extension ViewController {
    func embedViews() {
        view.addSubview(testLabel)
    }
}

private extension ViewController {
    func setupLayout() {
        testLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

private extension ViewController {
    func setupAppearance() {
        view.backgroundColor = .white

        testLabel.textColor = .black
        testLabel.font = .systemFont(ofSize: 30, weight: .semibold)
    }
}

private extension ViewController {
    func setupBehavior() {}
}
