//
//  File.swift
//  
//
//  Created by Bryan A Bolivar M on 25/09/23.
//

import Foundation

//MARK: - Session Model

public struct Session: Codable {
    public let accessToken: String
    public let tokenType: String
    public let expiresIn: Int
    public let refreshToken: String
    public let createdAt: Int
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case createdAt = "created_at"
    }
}

//MARK: - Networking Structure

public struct SessionResponse: Codable {
    private let data: ResponseData
    
    public var session: Session {
        return data.attributes
    }
}

public struct ResponseData: Codable {
    public let attributes: Session
}
