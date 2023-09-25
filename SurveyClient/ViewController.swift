//
//  ViewController.swift
//  SurveyClient
//
//  Created by Bryan A Bolivar M on 24/09/23.
//

import UIKit
import Core
import Style
import API

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        signIn()
    }
    
    func signIn() {
        APIProvider.request(service: .loginWithEmail(email: "bolivarbryan@gmail.com",
                                                     password: "12345678")) { data in
            DispatchQueue.main.async {
                do {
                    let session = try JSONDecoder().decode(SessionResponse.self, from: data)
                    print(session.session)
                    AccessToken.save(session.session.accessToken)
                    TokenType.save(session.session.tokenType)
                    RefreshToken.save(session.session.refreshToken)
                    self.surveyList()
                } catch {
                    print(error.localizedDescription)
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
