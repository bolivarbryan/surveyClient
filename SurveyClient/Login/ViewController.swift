//
//  ViewController.swift
//  SurveyClient
//
//  Created by Bryan A Bolivar M on 24/09/23.
//

import UIKit
import Core
import Style
import SnapKit

class ViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!
    
    var logoImage: UIImage {
        return UIImage(named: "logo") ?? UIImage()
    }
    
    var imageView: UIImageView {
        let imageView = UIImageView(frame: .zero)
        imageView.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        imageView.image = logoImage
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    var emailTextField: UITextField = {
        return Component.generateTextField(placeholder: Language.Login.email)
    }()
    
    var passwordTextField: UITextField = {
        let textField = Component.generateTextField(placeholder: Language.Login.password)
        textField.isSecureTextEntry = true
        return textField
    }()
    
    var button: UIButton = {
        return Component.generateButton(title: Language.Login.login, backgroundColor: ColorStyle.white)
    }()
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareLayout()
        
        viewModel.didSignInSuccessfully = {
            self.performSegue(withIdentifier: "HomeSegue", sender: self)
        }
        
        emailTextField.addTarget(self, action: #selector(updateEmailTextField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(updatePasswordTextField), for: .editingChanged)
        button.addTarget(self, action: #selector(performLogin), for: .touchUpInside)
        
        #if DEBUG
        emailTextField.text = "bolivarbryan@gmail.com"
        passwordTextField.text = "12345678"
        viewModel.email = "bolivarbryan@gmail.com"
        viewModel.password = "12345678"
        #endif
    }
    
    func prepareLayout() {
        stackView.addArrangedSubview(Component.generateEmptyView(height: 153))
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(Component.generateEmptyView(height: 109))
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(Component.generateEmptyView())
    }
    
    @objc func updateEmailTextField() {
        viewModel.email = emailTextField.text ?? ""
    }
    
    @objc func updatePasswordTextField() {
        viewModel.password = passwordTextField.text ?? ""
    }
    
    @objc func performLogin() {
        viewModel.performLogin()
    }
}
