//
//  LogInViewController.swift
//  EventifyApp
//
//  Created by Станислав on 19.03.2024.
//

import UIKit
import SnapKit

final class LogInViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход"
        label.font = .systemFont(ofSize: 40, weight: .semibold)
        label.textColor = .white
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = """
        Пожалуйста,  войдите в свой аккаунт.
        Это займёт меньше минуты.
        """
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(red: 0.523, green: 0.523, blue: 0.568, alpha: 1)
        label.numberOfLines = 0
        return label
    }()

    private lazy var emailTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.backgroundColor = .clear
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.white.cgColor
        field.keyboardType = .emailAddress
        field.returnKeyType = .next
        field.textColor = .white
        let placeholder = field.placeholder ?? ""
        field.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.gray]
        )
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: field.frame.height))
        field.leftViewMode = .always
        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 104, height: field.frame.height))
        field.rightViewMode = .always
        return field
    }()

    private lazy var passwordTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Пароль"
        field.backgroundColor = .clear
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.white.cgColor
        field.isSecureTextEntry = true
        field.returnKeyType = .done
        field.textColor = .white

        let placeholder = field.placeholder ?? ""
        field.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.gray]
        )

        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: field.frame.height))
        field.leftViewMode = .always

        var eyeButtonConfig = UIButton.Configuration.plain()
        eyeButtonConfig.image = UIImage(systemName: "eye")
        eyeButtonConfig.baseForegroundColor = UIColor.gray

        let eyeButton = UIButton(configuration: eyeButtonConfig)
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)

        let eyeButtonWidth = eyeButton.intrinsicContentSize.width + 16
        let totalRightViewWidth = eyeButtonWidth + 60

        let rightViewContainer = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: totalRightViewWidth,
                height: eyeButton.intrinsicContentSize.height
            )
        )

        eyeButton.frame = CGRect(x: 60, y: 0, width: eyeButtonWidth, height: eyeButton.intrinsicContentSize.height)
        rightViewContainer.addSubview(eyeButton)

        field.rightView = rightViewContainer
        field.rightViewMode = .always

        return field
    }()

    private lazy var forgetPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Забыли пароль?"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(red: 0.523, green: 0.523, blue: 0.568, alpha: 1)
        return label
    }()

    private lazy var enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(hex: "DDF14A")
        button.layer.cornerRadius = 10
        return button
    }()

    private lazy var dontHaveAnAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Нет аккаунта?", for: .normal)
        button.setTitleColor(UIColor(red: 0.523, green: 0.523, blue: 0.568, alpha: 1), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        return button
    }()
    private lazy var registrationButton: UIButton = {
        let button = UIButton()

        let attributedTitle = NSAttributedString(
            string: "Регистрация",
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor(hex: "DDF14A"),
                .font: UIFont.systemFont(ofSize: 16, weight: .regular)
            ]
        )

        button.setAttributedTitle(attributedTitle, for: .normal)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
    }

    private func setupViews() {
        view.backgroundColor = UIColor(hex: "#161618")

        view.addSubviews(registrationButton,
                         dontHaveAnAccountButton,
                         enterButton,
                         passwordTextField,
                         emailTextField,
                         titleLabel,
                         descriptionLabel,
                         forgetPasswordLabel
        )
    }

    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(153)
            make.leading.equalToSuperview().offset(16)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
        }

        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }

        enterButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(60)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }

        dontHaveAnAccountButton.snp.makeConstraints { make in
            make.top.equalTo(enterButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(120)
        }

        registrationButton.snp.makeConstraints { make in
            make.leading.equalTo(dontHaveAnAccountButton.snp.trailing).offset(12)
            make.top.equalTo(enterButton.snp.bottom).offset(20)
            make.bottom.equalTo(dontHaveAnAccountButton.snp.bottom)
        }

        forgetPasswordLabel.snp.makeConstraints { make in
            make.trailing.equalTo(passwordTextField.snp.trailing)
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
        }
    }

    @objc
    private func togglePasswordVisibility(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        let eyeImageName = passwordTextField.isSecureTextEntry ? "eye" : "eye.slash"
        sender.setImage(UIImage(systemName: eyeImageName), for: .normal)
    }
}