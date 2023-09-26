//
//  File.swift
//  
//
//  Created by Bryan A Bolivar M on 25/09/23.
//

import Foundation

public struct User: Codable {
    public let email: String
    public let name: String
    public let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
         case email, name
         case avatarURL = "avatar_url"
     }
}


//MARK: - Networking Structure

public struct UserResponse: Codable {
    private let data: ResponseUserData
    
    public var user: User {
        return data.attributes
    }
}

public struct ResponseUserData: Codable {
    public let attributes: User
}
