//
//  NetvorkManager.swift
//  Navigation
//
//  Created by Anastasiya on 04.07.2024.
//

import Foundation

enum AppConfiguration: String, CaseIterable{
    case film = "https://swapi.dev/api/films/8"
    case starship = "https://swapi.dev/api/starships/3"
    case planet = "https://swapi.dev/api/planets/5"
    
}

struct NetvorkManager{
    
    static func request(for configuration: AppConfiguration) {
        
        print("Request")
        
        guard let url = URL(string: configuration.rawValue)  else {return}
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) {data, response, error in
            if let error {
                print("Ошибка: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Код ответа: \(httpResponse.statusCode)")
                print("Заголовки: \(httpResponse.allHeaderFields)")
            }
            
            guard let data else {
                print("Нет данных!")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print("Данные получены: \(json)")
            } catch {
                print("Ошибка обработки JSON: \(error.localizedDescription)")
                
            }
        }
        task.resume()
    }
    
}
