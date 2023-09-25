//
//  File.swift
//  
//
//  Created by Bryan A Bolivar M on 25/09/23.
//

import Foundation


public protocol Storage {
    static func save(_ value: String)
    static func fetch() -> String
}

public struct AccessToken: Storage {
    private static let tokenKey = "user_access_token"
    
    public static func save(_ value: String) {
        UserDefaults.standard.setValue(value, forKey: tokenKey)
    }
    
    public static func fetch() -> String {
        UserDefaults.standard.string(forKey: tokenKey) ?? ""
    }
}

public struct TokenType: Storage {
    private static let tokenKey = "user_token_type"
    
    public static func save(_ value: String) {
        UserDefaults.standard.setValue(value, forKey: tokenKey)
    }
    
    public  static func fetch() -> String {
        UserDefaults.standard.string(forKey: tokenKey) ?? ""
    }
}

public struct RefreshToken: Storage {
    private static let tokenKey = "refresh_token"
    
    public static func save(_ value: String) {
        UserDefaults.standard.setValue(value, forKey: tokenKey)
    }
    
    public  static func fetch() -> String {
        UserDefaults.standard.string(forKey: tokenKey) ?? ""
    }
}
