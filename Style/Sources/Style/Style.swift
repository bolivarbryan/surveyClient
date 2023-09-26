// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit
import SnapKit

public struct Language {
    public struct Login {
        public static let email = "Email"
        public static let password = "Password"
        public static let forgot = "Forgot?"
        public static let login = "Log in"
    }
    
    public struct PasswordRecover {
        public static let title = "Enter your email to receive instructions for resetting your password."
        public static let email = "Email"
        public static let reset = "Reset"
        public static let titleAlert = "Check your email."
        public static let bodyAlert = "We’ve email you instructions to reset your password."
    }
    
    public struct Home {
        public static let dayFormat = "EEEE, MMMM d"
    }
}

public struct FontStyle {
    public static let xSmall13 = UIFont(name: "Helvetica", size: 13)
    public static let xSmall18 = UIFont(name: "Helvetica", size: 18)
    public static let largeTitle34 = UIFont(name: "Helvetica", size: 34)
    public static let display28 = UIFont(name: "Helvetica", size: 28)
    public static let regular17 = UIFont(name: "Helvetica", size: 17)
    public static let semibold17 = UIFont(name: "Helvetica-Bold", size: 17)
}

public struct Component {
    public static func generateButton(title: String, backgroundColor: UIColor = ColorStyle.white, titleColor: UIColor = ColorStyle.gray) -> UIButton {
        let button = UIButton(frame: .zero)
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = FontStyle.semibold17
        button.layer.cornerRadius = 10
        
        button.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
        return button
    }
    
    public static func generateTextField(placeholder: String, backgroundColor: UIColor = ColorStyle.white18) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.backgroundColor = backgroundColor
        textField.placeholder = placeholder
        textField.layer.cornerRadius = 12
        textField.clipsToBounds = true
        
        textField.attributedPlaceholder = NSAttributedString(string:placeholder,
                                                             attributes: [NSAttributedString.Key.foregroundColor: ColorStyle.white30])
        textField.textColor = ColorStyle.white
        
        textField.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
        textField.setLeftPaddingPoints(12)
        
        return textField
    }
    
    public static func generateEmptyView(height: CGFloat? = nil) -> UIView {
        let view = UIView(frame: .zero)
        if let height = height  {
            view.snp.makeConstraints { make in
                make.height.equalTo(height)
            }
        }
        return view
    }
}

public struct ColorStyle {
    public static let white: UIColor = .white
    public static let white70: UIColor = UIColor(red: 0.082, green: 0.082, blue: 0.102, alpha: 0.7)
    public static let white30: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
    public static let white18: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.18)
    public static let gray: UIColor = UIColor(red: 0.082, green: 0.082, blue: 0.102, alpha: 1)
    
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
