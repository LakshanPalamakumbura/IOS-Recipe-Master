//
//  APICaller.swift
//  Receipie App
//
//  Created by Lakshan Palamakumbura on 2023-01-27.
//

import Foundation


enum APIError: Error {
    
    case failedTogetData
}


class APICaller {
    
    static let shared = APICaller()
    
    func getBreakfast(completion: @escaping (Result<[Response], Error>)->Void){
         guard let url = URL(string: "http://127.0.0.1:8000/api/food")else {return}
         
         let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data, _, error in
             guard let data = data, error == nil else {
                 return
                 }
             do {
                 let results = try JSONDecoder().decode([Response].self, from: data)
                 let breakfast = Array(results.prefix(5))
                 completion(.success(breakfast))
             }catch{
                 completion(.failure(error))
             }
         }
         task.resume()
     }

    func getMain(completion: @escaping (Result<[Response], Error>)->Void){
         guard let url = URL(string: "http://127.0.0.1:8000/api/food")else {return}

         let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data, _, error in
             guard let data = data, error == nil else {
                 return
                 }
             do {
                 let results = try JSONDecoder().decode([Response].self, from: data)
                 let main = Array(results.suffix(8))
                 let mainDish = Array(main.prefix(5))
                 completion(.success(mainDish))
                                
             }catch{
                 completion(.failure(error))
             }
         }
         task.resume()
     }

    func getDessart(completion: @escaping (Result<[Response], Error>)->Void){
         guard let url = URL(string: "http://127.0.0.1:8000/api/food")else {return}

         let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data, _, error in
             guard let data = data, error == nil else {
                 return
                 }
             do {
                 let results = try JSONDecoder().decode([Response].self, from: data)
                 let desert = Array(results.suffix(3))
                 completion(.success(desert))
             }catch{
                 completion(.failure(error))
             }
         }
         task.resume()
     }

    func getDetail(completion: @escaping (Result<[Response], Error>)->Void){
         guard let url = URL(string: "http://127.0.0.1:8000/api/food")else {return}

         let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data, _, error in
             guard let data = data, error == nil else {
                 return
                 }
             do {
                 let results = try JSONDecoder().decode([Response].self, from: data)
//                 print(results)
//                 print(results[0].name)

//                 for i in 0..<2 {
//                     print(results[i].name)
//                 }
                 completion(.success(results))
             }catch{
                 completion(.failure(error))
             }
         }
         task.resume()
     }
    

    func getFavourite(completion: @escaping (Result<[FavouriteResponse], Error>)->Void){
         guard let url = URL(string: "http://127.0.0.1:8000/api/userfavourite")else {return}
        guard let token = UserDefaults.standard.string(forKey: "token") else {return}

        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
         let task = URLSession.shared.dataTask(with: request){data, _, error in
             guard let data = data, error == nil else {
                 return
                 }
//             print("\(String(data: data, encoding: .utf8))")
//             print(token)
             do {
                 let results = try JSONDecoder().decode([FavouriteResponse].self, from: data)
                 completion(.success(results))
                                
             }catch{
                 completion(.failure(error))
             }
         }
         task.resume()
     }
}






