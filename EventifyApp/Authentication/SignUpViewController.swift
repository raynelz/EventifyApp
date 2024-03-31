//
//  SignUpViewController.swift
//  EventifyApp
//
//  Created by Станислав on 19.03.2024.
//

import UIKit
import SnapKit
import FirebaseAuth

final class SignUpViewController: UIViewController {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = .systemFont(ofSize: 40, weight: .semibold)
        label.textColor = .white

        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = """
        Пожалуйста, создайте новый аккаунт.
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
        field.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.gray])

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
        field.delegate = self

        let placeholder = field.placeholder ?? ""
        field.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.gray])

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

    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(hex: "DDF14A")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(registerAccount), for: .touchUpInside)
        return button
    }()

    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Уже есть аккаунт?"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(hex: "#858591")

        return label
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()

        let attributedTitle = NSAttributedString(
            string: "Войти",
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor(hex: "DDF14A"),
                .font: UIFont.systemFont(ofSize: 17, weight: .regular)
            ]
        )

        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(loginSegue), for: .touchUpInside)
        return button
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Введен некорректный формат электронной почты/пароля."
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(hex: "#FF8F88")
        label.isHidden = true
        return label
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
            loginButton,
            questionLabel,
            registerButton,
            passwordTextField,
            emailTextField,
            titleLabel,
            descriptionLabel,
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

        registerButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(60)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }

        questionLabel.snp.makeConstraints {
            $0.top.equalTo(registerButton.snp.bottom).offset(22)
            $0.leading.equalToSuperview().offset(120)
        }

        loginButton.snp.makeConstraints {
            $0.leading.equalTo(questionLabel.snp.trailing).offset(12)
            $0.top.equalTo(registerButton.snp.bottom).offset(22)
            $0.bottom.equalTo(questionLabel.snp.bottom)
        }
        
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(registerButton.snp.bottom).offset(140)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(89)
        }
    }

    @objc
    private func togglePasswordVisibility(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        let eyeImageName = passwordTextField.isSecureTextEntry ? "eye" : "eye.slash"
        sender.setImage(UIImage(systemName: eyeImageName), for: .normal)
    }

    @objc
    private func registerAccount(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        let userModel = UserModel(email: email, password: password)

        AuthService.shared.registerUser(with: userModel) { wasRegistered, error in
            if let error = error {
                self.emailTextField.layer.borderColor = UIColor(hex: "#FF8F88").cgColor
                self.passwordTextField.layer.borderColor = UIColor(hex: "#FF8F88").cgColor
                
                self.errorLabel.isHidden = false
                
                Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { [weak self] _ in
                    self?.emailTextField.layer.borderColor = UIColor.white.cgColor
                    self?.passwordTextField.layer.borderColor = UIColor.white.cgColor
                    
                    self?.errorLabel.isHidden = true
                }
                print(error.localizedDescription)
            } else {
                print("wasRegistered", wasRegistered)
                if let window = self.view.window {
                    let nextVC = AppTabBarController()
                    window.rootViewController = nextVC
                    window.makeKeyAndVisible()
                    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {})
                }
            }
        }
    }

    @objc
    private func loginSegue(_ sender: UIButton) {
        let nextVC = LogInViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }

}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        registerAccount(UIButton())
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
