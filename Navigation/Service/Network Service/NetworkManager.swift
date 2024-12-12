//
//  NetworkManager.swift
//  Navigation
//
//  Created by Anastasiya on 04.07.2024.
//

import Foundation

enum AppConfiguration: String, CaseIterable{
    case people = "https://swapi.dev/api/people/8"
    case starship = "https://swapi.dev/api/starships/3"
    case planet = "https://swapi.dev/api/planets/5"
    
}

struct NetworkManager{
    
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
    
    static func getTitle(completion: @escaping (Result<String, Error>) -> Void){
        let urlString = "https://jsonplaceholder.typicode.com/todos/11"
        
        let url = URL(string: urlString)!
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error {
                print("Ошибка: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
                return
            }
            
            guard let data else {
                return
            }
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                guard let title = json?["title"] as? String else { return }
                completion(.success(title))
            }catch{
                print("Ошибка")
            }
            
        }
        task.resume()
    }
    
    static func getPlanet(completion: @escaping (Result<Planet, Error>) -> Void){
        let urlString = "https://swapi.dev/api/planets/1"
        
        let url = URL(string: urlString)!
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error {
                print("Ошибка: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
                return
            }
            
            guard let data else {
                return
            }
            do{
                let planet = try JSONDecoder().decode(Planet.self, from: data)
                completion(.success(planet))
            }catch{
                print("Ошибка")
            }
            
        }
        task.resume()
    }
    
    static func getResidentsPlanet(planet: Planet, completion: @escaping (Result<[ResidentPlanet], Error>) -> Void){
            var residents = [ResidentPlanet]()
            var count = planet.residents.count
            planet.residents.forEach{ urlResindet in
                getResidentPlanet(urlString: urlResindet)
               { result in
                    switch result{
                        
                    case .success(let resident):
             
                        residents.append(resident)
                    case .failure(_): break
                        
                    }
                    count-=1
                    if(count == 0){
                        completion(.success(residents))
                    }
                }
                
            }
           
        }
    
    static func getResidentPlanet(urlString: String, completion: @escaping (Result<ResidentPlanet, Error>) -> Void){
        
            let url = URL(string: urlString)!
            
            let tast = URLSession.shared.dataTask(with: url){ data, response, error in
                
                if let error {
                    print("Ошибка: \(error.localizedDescription)")
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
                    print("responce")
                    return
                }
                
                guard let data else {
                    return
                }
                
                do{
                    let residentPlanet = try JSONDecoder().decode(ResidentPlanet.self, from: data)
                    completion(.success(residentPlanet))
                }catch{
                    print("Ошибка")
                }
                
            }
            
            tast.resume()
            
            
        }
    
}
