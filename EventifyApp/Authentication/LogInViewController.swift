//
//  LogInViewController.swift
//  EventifyApp
//
//  Created by Станислав on 19.03.2024.
//

import UIKit
import SnapKit
import FirebaseAuth

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
        label.textColor = UIColor(hex: "#858591")
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
        field.delegate = self
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

    private lazy var forgetPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Забыли пароль?", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.setTitleColor(UIColor(hex: "#858591"), for: .normal)
        button.addTarget(self, action: #selector(restorePassword), for: .touchUpInside)
        return button
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(hex: "#DDF14A")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(loginIntoAccount), for: .touchUpInside)
        return button
    }()

    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Нет аккаунта?"
        label.textColor = UIColor(hex: "#858591")
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    private lazy var registrationButton: UIButton = {
        let button = UIButton()

        let attributedTitle = NSAttributedString(
            string: "Регистрация",
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor(hex: "#DDF14A"),
                .font: UIFont.systemFont(ofSize: 16, weight: .regular)
            ]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(registrationSegue), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
    }

    private func setupViews() {
        view.backgroundColor = UIColor(hex: "#161618")
        navigationItem.setHidesBackButton(true, animated: true)
        view.addSubviews(
            registrationButton,
            questionLabel,
            loginButton,
            passwordTextField,
            emailTextField,
            titleLabel,
            descriptionLabel,
            forgetPasswordButton
        )
    }

    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(153)
            $0.leading.equalToSuperview().offset(16)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
        }

        emailTextField.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }

        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }

        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(60)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }

        questionLabel.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(120)
        }

        registrationButton.snp.makeConstraints {
            $0.leading.equalTo(questionLabel.snp.trailing).offset(12)
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
            $0.bottom.equalTo(questionLabel.snp.bottom)
        }

        forgetPasswordButton.snp.makeConstraints {
            $0.trailing.equalTo(passwordTextField.snp.trailing)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(8)
        }
    }

    @objc
    private func loginIntoAccount(_ sender: UIButton) {
        let nextVc = AppTabBarController()

        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        let userModel = UserModel(email: email, password: password)
        AuthService.shared.loginUser(with: userModel) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let window = self.view.window {
                    window.rootViewController = nextVc
                    window.makeKeyAndVisible()
                    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {})
                }
            }
        }
    }
    
    @objc
    private func registrationSegue(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @objc
    private func restorePassword(_ sender: UIButton) {
        let nextVC = ResetPasswordViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }

    @objc
    private func togglePasswordVisibility(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        let eyeImageName = passwordTextField.isSecureTextEntry ? "eye" : "eye.slash"
        sender.setImage(UIImage(systemName: eyeImageName), for: .normal)
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
        loginIntoAccount(UIButton())
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
