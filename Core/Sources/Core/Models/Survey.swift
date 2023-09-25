//
//  File.swift
//  
//
//  Created by Bryan A Bolivar M on 25/09/23.
//

import Foundation

public struct Survey: Codable {
    let title, description, thankEmailAboveThreshold, thankEmailBelowThreshold: String
    let isActive: Bool
    let coverImageURL: String
    let createdAt, activeAt: String
    let surveyType: String

    enum CodingKeys: String, CodingKey {
        case title, description
        case thankEmailAboveThreshold = "thank_email_above_threshold"
        case thankEmailBelowThreshold = "thank_email_below_threshold"
        case isActive = "is_active"
        case coverImageURL = "cover_image_url"
        case createdAt = "created_at"
        case activeAt = "active_at"
        case surveyType = "survey_type"
    }
}

//MARK: - Networking Structure

public struct SurveyResponse: Codable {
    private let data: [SurveyData]
    
    public var surveys: [Survey] {
        return data.map { $0.attributes }
    }
}

public struct SurveyData: Codable {
    public let attributes: Survey
}
