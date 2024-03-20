//
//  SignUpViewController.swift
//  EventifyApp
//
//  Created by Станислав on 19.03.2024.
//

import UIKit
import SnapKit

final class SignUpViewController: UIViewController {
    
    // Главный текст
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = .systemFont(ofSize: 40, weight: .semibold)
        label.textColor = .white
        
        return label
    }()
    
    // Текст описания
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = """
        Пожалуйста, создайте новый аккаунт.
        Это займёт меньше минуты.
        """
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(red: 0.523, green: 0.523, blue: 0.568, alpha: 1)
        label.numberOfLines = 0 // Устанавливаем максимальное количество строк равным 2
        
        return label
    }()
    
    // Email Text Field
    private lazy var emailTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.backgroundColor = .clear
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.white.cgColor
        field.autocapitalizationType = .none
        field.keyboardType = .emailAddress
        field.returnKeyType = .next
        field.textColor = .white
        
        let placeholder = field.placeholder ?? ""
        field.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.gray])
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: field.frame.height))
        field.leftViewMode = .always
        
        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 104, height: field.frame.height))
        field.rightViewMode = .always
        
        return field
    }()
    
    // Password Text Field
    private lazy var passwordTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Пароль"
        field.backgroundColor = .clear
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.white.cgColor
        field.autocapitalizationType = .none
        field.isSecureTextEntry = true
        field.returnKeyType = .done
        field.textColor = .white

        // Настройка placeholder
        let placeholder = field.placeholder ?? ""
        field.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.gray])

        // Отступ слева
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: field.frame.height))
        field.leftViewMode = .always

        // Иконка глаза
        var eyeButtonConfig = UIButton.Configuration.plain()
        eyeButtonConfig.image = UIImage(systemName: "eye")
        eyeButtonConfig.baseForegroundColor = UIColor.gray

        let eyeButton = UIButton(configuration: eyeButtonConfig)
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)

        // Ширина для eyeButton с учетом отступов
        let eyeButtonWidth = eyeButton.intrinsicContentSize.width + 16
        let totalRightViewWidth = eyeButtonWidth + 60

        // Создаем контейнер для eyeButton и дополнительного пространства
        let rightViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: totalRightViewWidth, height: eyeButton.intrinsicContentSize.height))
        
        // Позиционируем eyeButton в контейнере
        eyeButton.frame = CGRect(x: 60, y: 0, width: eyeButtonWidth, height: eyeButton.intrinsicContentSize.height)
        rightViewContainer.addSubview(eyeButton)

        field.rightView = rightViewContainer
        field.rightViewMode = .always

        return field
    }()


    // Основная кнопка
    private lazy var mainButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегестрироваться", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(hex: "DDF14A")  // Исходный цвет фона
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    // Текст под кнопкой основной кнопкой
    private lazy var textUnderButton: UILabel = {
        let label = UILabel()
        label.text = "Уже есть аккаунт?"
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(red: 0.523, green: 0.523, blue: 0.568, alpha: 1)
        return label
        
    }()
    
    // Кнопка под основной кнопкой
    private lazy var enterButton: UIButton = {
        let button = UIButton()
        
        let attributedTitle = NSAttributedString(
            string: "Войти",
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor(hex: "DDF14A"),
                .font: UIFont.systemFont(ofSize: 17, weight: .regular)
            ])
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }()

    
    // Изменение видимости Password Field
    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        let eyeImageName = passwordTextField.isSecureTextEntry ? "eye" : "eye.slash"
        sender.setImage(UIImage(systemName: eyeImageName), for: .normal)
    }
    
    // Добавление ф-ий
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupViews()
        setupLayout()
    }
    
    // Добавление новых View
    private func addViews() {
        view.addSubview(enterButton)
        view.addSubview(textUnderButton)
        view.addSubview(mainButton)
        view.addSubview(passwordTextField)
        view.addSubview(emailTextField)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(hex: "#161618")
    }
    
    // Констрейты
    private func setupLayout() {
        // Главная надпись
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(153)
            make.leading.equalToSuperview().offset(16)
        }
        
        // Описание
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
        }
        
        // Email
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        // Password
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        // Основная кнопка
        mainButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(60)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        // Текст под основной кнопкой
        textUnderButton.snp.makeConstraints { make in
            make.top.equalTo(mainButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(120)
        }
        
        // Кнопка под основной кнопкой
        enterButton.snp.makeConstraints { make in
            make.leading.equalTo(textUnderButton.snp.trailing).offset(12)
            make.top.equalTo(mainButton.snp.bottom).offset(20)
            make.bottom.equalTo(textUnderButton.snp.bottom)
        }
        
    }
    
    
    
    
}
