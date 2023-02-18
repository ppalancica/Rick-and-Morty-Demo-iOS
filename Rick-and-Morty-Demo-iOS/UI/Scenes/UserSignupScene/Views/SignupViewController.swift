//
//  SignupViewController.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 18.02.2023.
//

import UIKit

protocol SignupViewControllerDelegate: AnyObject {
    
    func didTapSignup(email: String,
                      password: String,
                      inside viewController: SignupViewController)
    
    func didTapSignin(inside viewController: SignupViewController)
}

final class SignupViewController: UIViewController {
    
    weak var delegate: SignupViewControllerDelegate?
    
    lazy var scrollView = makeScrollView()
    lazy var rootStackView = makeRootStackView()
    
    lazy var emailLabel = makeEmailLabel()
    lazy var emailTextField = makeEmailTextField()
    lazy var emailBottomSeparator = makeEmailBottomSeparator()
    
    lazy var passwordLabel = makePasswordLabel()
    lazy var passwordTextField = makePasswordTextField()
    lazy var passwordBottomSeparator = makePasswordBottomSeparator()
    
    lazy var signupButton = makeSignupButton()
    
    lazy var signinStackView = makeSigninStackView()
    lazy var signinLabel = makeSigninLabel()
    lazy var signinButton = makeSigninButton()
    
    init(delegate: SignupViewControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupViews()
        setupLayoutConstraints()
        
        emailTextField.delegate = self
        scrollView.delegate = self

        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(handleScrollViewTapGesture)
        )
        scrollView.addGestureRecognizer(tapGestureRecognizer)
        
        signupButton.addTarget(self, action: #selector(handleSignupButtonTap), for: .touchUpInside)
        signinButton.addTarget(self, action: #selector(handleSigninButtonTap), for: .touchUpInside)
    }
}

// MARK: - UI Action Methods

private extension SignupViewController {
    
    @objc func handleScrollViewTapGesture() {
        if emailTextField.isFirstResponder {
            emailTextField.resignFirstResponder()
        } else if passwordTextField.isFirstResponder {
            passwordTextField.resignFirstResponder()
        } else {
            view.endEditing(true)
        }
    }
    
    @objc func handleSignupButtonTap() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let delegate = delegate else { return }
        delegate.didTapSignup(email: email, password: password, inside: self)
    }
    
    @objc func handleSigninButtonTap() {
        guard let delegate = delegate else { return }
        delegate.didTapSignin(inside: self)
    }
}

// MARK: - UI Creation Methods

private extension SignupViewController {
    
    func setupViews() {
        title = "Sign up user"
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(rootStackView)
        
        rootStackView.addArrangedSubview(emailLabel)
        rootStackView.addArrangedSubview(emailTextField)
        rootStackView.addArrangedSubview(emailBottomSeparator)
        rootStackView.addArrangedSubview(passwordLabel)
        rootStackView.addArrangedSubview(passwordTextField)
        rootStackView.addArrangedSubview(passwordBottomSeparator)
        rootStackView.addArrangedSubview(signupButton)
        rootStackView.addArrangedSubview(UIView())
        rootStackView.addArrangedSubview(signinStackView)
        
        signinStackView.addArrangedSubview(UIView())
        signinStackView.addArrangedSubview(signinLabel)
        signinStackView.addArrangedSubview(signinButton)
        signinStackView.addArrangedSubview(UIView())
    }
    
    func setupLayoutConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailBottomSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordBottomSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signinStackView.translatesAutoresizingMaskIntoConstraints = false
        signinLabel.translatesAutoresizingMaskIntoConstraints = false
        signinButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            rootStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15),
            rootStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            rootStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -15),
            rootStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            rootStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -30),
            
            emailLabel.heightAnchor.constraint(equalToConstant: 30),
            emailTextField.heightAnchor.constraint(equalToConstant: 30),
            emailBottomSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            passwordLabel.heightAnchor.constraint(equalToConstant: 30),
            passwordTextField.heightAnchor.constraint(equalToConstant: 30),
            passwordBottomSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            signupButton.heightAnchor.constraint(equalToConstant: 45),
            signinStackView.heightAnchor.constraint(equalToConstant: 60),
            rootStackView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor, constant: -30)
        ])
        
        rootStackView.setCustomSpacing(30, after: emailBottomSeparator)
        rootStackView.setCustomSpacing(60, after: passwordBottomSeparator)
    }
    
    func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = .clear
        return scrollView
    }
    
    func makeRootStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }
    
    func makeEmailLabel() -> UILabel {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.text = "Email"
        return label
    }
    
    func makeEmailTextField() -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.placeholder = "john.doe@gmail.com"
        return textField
    }
    
    func makeEmailBottomSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }
    
    func makePasswordLabel() -> UILabel {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.text = "Password"
        return label
    }
    
    func makePasswordTextField() -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.placeholder = "john.doe@gmail.com"
        return textField
    }
    
    func makePasswordBottomSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }
    
    func makeSignupButton() -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.setTitle("Sign up", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }
    
    func makeSigninStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }
    
    func makeSigninLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .right
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.text = "Existing user?"
        return label
    }
    
    func makeSigninButton() -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.contentHorizontalAlignment = .left
        button.setTitle("Sign in", for: .normal)
        return button
    }
}

// MARK: - UITextFieldDelegate Methods

extension SignupViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UIScrollViewDelegate Methods

extension SignupViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if emailTextField.isFirstResponder {
            emailTextField.resignFirstResponder()
        } else if passwordTextField.isFirstResponder {
            passwordTextField.resignFirstResponder()
        } else {
            view.endEditing(true)
        }
    }
}
