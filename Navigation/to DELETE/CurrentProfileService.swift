//
//  CurrentProfileService.swift
//  Navigation
//
//  Created by Anastasiya on 24.12.2024.
//

import Foundation

class CurrentProfileService {
    
    static let shared = CurrentProfileService()
    
    var currentProfile: UserData?
    
    private init(){}
    
    //установить профиль
    func setCurrentProfile(with email: String) {
        UserDefaults.standard.set(email, forKey: "email")
    }
    
    //удалить профиль
    func removeCurrentProfile() {
        UserDefaults.standard.removeObject(forKey: "email")
    }
    
    //получить профиль
    func featchCurrentProfile() -> String? {
        UserDefaults.standard.string(forKey: "email")
    }
    
}
