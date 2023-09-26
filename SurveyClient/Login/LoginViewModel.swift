//
//  LoginViewModel.swift
//  SurveyClient
//
//  Created by Bryan A Bolivar M on 25/09/23.
//

import Foundation
import API
import Core

class LoginViewModel {
    enum State {
        case idle
        case editing
        case processingLogin
        case errorLogin
        case successfulLogin
    }
    
    var state: State = .idle {
        didSet {
            switch state {
            case .idle:
                break
            case .editing:
                if let response = self.didStartEditing {
                    response()
                }
            case .processingLogin:
                if let response = self.didStartProccessing {
                    response()
                }
            case .errorLogin:
                if let response = self.didFailLogin {
                    response()
                }
            case .successfulLogin:
                if let response = self.didSignInSuccessfully {
                    response()
                }
            }
        }
    }
    
    var email: String = ""
    var password: String = ""
    
    var didSignInSuccessfully: (() -> Void)?
    var didStartEditing: (() -> Void)?
    var didStartProccessing: (() -> Void)?
    var didFailLogin: (() -> Void)?
    
    func performLogin() {
        state = .processingLogin
        APIProvider.request(service: .loginWithEmail(email: email, password: password)) { data in
            DispatchQueue.main.async {
                do {
                    let session = try JSONDecoder().decode(SessionResponse.self, from: data)
                    print(session.session)
                    AccessToken.save(session.session.accessToken)
                    TokenType.save(session.session.tokenType)
                    RefreshToken.save(session.session.refreshToken)
                    self.state = .successfulLogin
                } catch {
                    print(error.localizedDescription)
                    self.state = .errorLogin
                }
            }
        }
    }
    
    func refreshToken() {
        APIProvider.request(service: .refreshToken(token: RefreshToken.fetch())) { data in
            DispatchQueue.main.async {
                do {
                    let session = try JSONDecoder().decode(SessionResponse.self, from: data)
                    AccessToken.save(session.session.accessToken)
                    TokenType.save(session.session.tokenType)
                    RefreshToken.save(session.session.refreshToken)
                    print(session.session)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func logout() {
        APIProvider.request(service: .logout(token: AccessToken.fetch())) { data in
            DispatchQueue.main.async {
                print(data)
            }
        }
    }
    
    func surveyList() {
        APIProvider.request(service: .surveyList(page: 1)) { data in
            DispatchQueue.main.async {
                do {
                    let surveys = try JSONDecoder().decode(SurveyResponse.self, from: data)
                    print(surveys.surveys)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
