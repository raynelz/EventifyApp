//
//  LogInViewController.swift
//  EventifyApp
//
//  Created by Станислав on 19.03.2024.
//

import UIKit
import SnapKit
import FirebaseAuth

final class LoginViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход"
        label.font = .systemFont(ofSize: 40, weight: .semibold)
        label.textColor = .label
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = """
        Пожалуйста,  войдите в свой аккаунт.
        Это займёт меньше минуты.
        """
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()

    private lazy var emailTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.backgroundColor = .clear
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.textfieldTint.cgColor
        field.keyboardType = .emailAddress
        field.returnKeyType = .next
        field.textColor = .label
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
        field.layer.borderColor = UIColor.textfieldTint.cgColor
        field.isSecureTextEntry = true
        field.returnKeyType = .done
        field.textColor = .label
        field.delegate = self

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
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.addTarget(self, action: #selector(restorePassword), for: .touchUpInside)
        return button
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .brandYellow
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(loginIntoAccount), for: .touchUpInside)
        return button
    }()

    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Нет аккаунта?"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    private lazy var registrationButton: UIButton = {
        let button = UIButton()

        // swiftlint: disable all
        let attributedTitle = NSAttributedString(
            string: "Регистрация",
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor(named: "brandYellow")!,
                .font: UIFont.systemFont(ofSize: 16, weight: .regular)
            ]
        )
        // swiftlint: enable all
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(registrationSegue), for: .touchUpInside)
        return button
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Неправильно введён email или пароль."
        label.font = .systemFont(ofSize: 14)
        label.textColor = .error
        label.isHidden = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
    }

    private func setupViews() {
        view.backgroundColor = .authBackground
        navigationItem.setHidesBackButton(true, animated: true)
        view.addSubviews(
            registrationButton,
            questionLabel,
            loginButton,
            passwordTextField,
            emailTextField,
            titleLabel,
            descriptionLabel,
            forgetPasswordButton,
            errorLabel
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
        
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(140)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(89)
        }
    }

    @objc
    private func loginIntoAccount(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        let userModel = UserModel(email: email, password: password)
        AuthService.shared.loginUser(with: userModel) { error in
            if let error = error {
                
                self.emailTextField.layer.borderColor = UIColor.error.cgColor
                self.passwordTextField.layer.borderColor = UIColor.error.cgColor

                self.errorLabel.isHidden = false
                
                Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { [weak self] _ in
                    self?.emailTextField.layer.borderColor = UIColor.textfieldTint.cgColor
                    self?.passwordTextField.layer.borderColor = UIColor.textfieldTint.cgColor

                    self?.errorLabel.isHidden = true
                }
                print(error.localizedDescription)
            } else {
                if let window = self.view.window {
                    let nextVc = AppTabBarController()
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

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        loginIntoAccount(UIButton())
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
