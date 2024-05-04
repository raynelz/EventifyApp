//
//  ResetPasswordViewController.swift
//  EventifyApp
//
//  Created by Станислав on 21.03.2024.
//

import UIKit
import SnapKit
import FirebaseAuth

final class ResetPasswordViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Сброс пароля"
        label.font = .systemFont(ofSize: 40, weight: .semibold)
        label.textColor = .label

        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = """
        Укажите email, который вы использовали для
        создания аккаунта. Мы отправим письмо с
        сыллкой для сброса пароля.
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
        field.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.gray])
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: field.frame.height))
        field.leftViewMode = .always
        
        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 104, height: field.frame.height))
        field.rightViewMode = .always
        
        return field
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отправить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .brandYellow
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(sendResetEmail), for: .touchUpInside)

        return button
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Электронная почта не найдена."
        label.numberOfLines = 0
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
        view.addSubviews(titleLabel, descriptionLabel, emailTextField, sendButton, errorLabel)
    }
    
    private func setupLayout() {
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(153)
            $0.leading.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(16)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        sendButton.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(46)
        }
        
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(sendButton.snp.bottom).offset(140)
            $0.centerX.equalToSuperview()
        }
    }

    @objc
    private func sendResetEmail(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        let userModel = UserModel(email: email, password: "no password")
        AuthService.shared.forgotPassword(with: userModel) { error in
            if let error = error {
                self.emailTextField.layer.borderColor = UIColor.error.cgColor
                
                self.errorLabel.isHidden = false
                
                Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { [weak self] _ in
                    self?.emailTextField.layer.borderColor = UIColor.textfieldTint.cgColor
                    
                    self?.errorLabel.isHidden = true
                }
                print(error.localizedDescription)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

extension ResetPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        sendResetEmail(UIButton())
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
