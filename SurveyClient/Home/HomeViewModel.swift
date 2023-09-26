//
//  HomeViewModel.swift
//  SurveyClient
//
//  Created by Bryan A Bolivar M on 25/09/23.
//

import Foundation
import API
import Core

class HomeViewModel {
    enum State {
        case loading
        case surveysLoaded
        case errorLoading
        case emptyState
    }
    
    var surveys: [Survey] = []
    var user: User?
    
    var state: State = .loading {
        didSet {
            switch state {
            case .loading:
                if let response = self.didStartLoading {
                    response()
                }
            case .surveysLoaded:
                if let response = self.didLoadSurveys {
                    response()
                }
            case .errorLoading:
                if let response = self.didFailLoading {
                    response()
                }
            case .emptyState:
                if let response = self.didLoadEmptySurveys {
                    response()
                }
            }
        }
    }
    
    var didStartLoading: (() -> Void)?
    var didLoadSurveys: (() -> Void)?
    var didFailLoading: (() -> Void)?
    var didLoadEmptySurveys: (() -> Void)?
    var didLoadUserProfile: (() -> Void)?

    
    func fetchSurveys() {
        state = .loading
        APIProvider.request(service: .surveyList(page: 1)) { data in
            DispatchQueue.main.async {
                do {
                    let surveys = try JSONDecoder().decode(SurveyResponse.self, from: data)
                    self.surveys = surveys.surveys
                    self.state = .surveysLoaded
                } catch {
                    print(error.localizedDescription)
                    self.state = .errorLoading
                }
            }
        }
    }
    
    func fetchUserProfile() {
        APIProvider.request(service: .userProfile) { data in
            DispatchQueue.main.async {
                do {
                    let response = try JSONDecoder().decode(UserResponse.self, from: data)
                    self.user = response.user
                    if let response = self.didLoadUserProfile {
                        response()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
