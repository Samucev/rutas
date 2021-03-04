//
//  APIManager.swift
//  listaContactosFinal
//
//  Created by alumnos on 05/02/2021.
//  Copyright © 2021 alumnos. All rights reserved.
//

import Foundation
import Alamofire

public var token = "TOKEN_KEY"
public var altitude = "ALTITUDE_KEY"
public var longitude = "LONGITUDE_KEY"


enum MyResult<T,E:Error> {
    case succes(T)
    case failure(E)
}

enum APIError:Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
}


class APIManager {
    
    let resourceURL: URL
    
    init(endpoint: String) {
        let resourceString = "http://localhost:8888/rutasAPI/public/api/\(endpoint)"
        
        //let resourceString = "https://superapi.netlify.app/\(endpoint)"
        
        guard let resourceURL = URL(string: resourceString)else {fatalError()}
        
        self.resourceURL = resourceURL
    }

    func register(_ userToSave: User, completion: @escaping(Swift.Result<User,Error>, Any?)->Void){
        
        
        Alamofire.request(resourceURL, method: .post, parameters: userToSave.getDictRegister(), encoding: JSONEncoding.default, headers: nil).responseData{ response in
            switch response.result{
                    
                case .success(let data):
                    
                    do{
                        
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        
                        if response.response?.statusCode == 200 {
                            
                            if let json = json as? [String: Any] {
                                let tokenJSON = json["message"]
                                
//                                if tokenJSON == 403 {
//                                    print(tokenJSON!)
//                                    completion(.success(userToSave), tokenJSON)
//
//
//                                }
                                
                                print(tokenJSON!)

                                completion(.success(userToSave), tokenJSON)
                            }
                            
//                            print(json)
//
//                            print("El usuario " + userToSave.name + " ha sido creado")
//
                            
                        }else{
                            print("No se ha podido crear el usuario")

                        }
                        
                        
                    }catch{
                        
                        print(response.response!.statusCode)
                        
                        print("Usuario o contraseña incorrectas")
                        
                        completion(.failure(APIError.decodingProblem), nil)
                    }
                    

                    
                    
                case .failure(_):
                    //print(err.localizedDescription)
                    completion(.failure(APIError.responseProblem), nil)
                }
            }
        
        
    }
    
    
    func login(_ userToSave: User, completion: @escaping(Swift.Result<User,Error>)->Void){
        
        Alamofire.request(resourceURL, method: .post, parameters: userToSave.getDictLogin(), encoding: JSONEncoding.default, headers: nil).responseData{ response in
            switch response.result{
                    
                case .success(let data):
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        
                        if response.response?.statusCode == 200 {
                            
                            print(json)
                            if let json = json as? [String: String] {
                                let tokenJSON = json["token"]
                                
                                UserDefaults.standard.set(tokenJSON, forKey: token)
                                UserDefaults.standard.synchronize()

                            }
                            
                            completion(.success(userToSave))
                        }else{
                            print(json)
                            completion(.failure(APIError.responseProblem))
                        }
                    }catch{
                        print(response.response!.statusCode)
                        
                        print("Usuario o contraseña incorrectas")
                        
                        completion(.failure(APIError.decodingProblem))
                    }
                    
                case .failure(_):
                    completion(.failure(APIError.responseProblem))
                }
            }
        }
    
    
    func changePass(_ userToSave: User, completion: @escaping(Swift.Result<User,Error>)->Void){
        
        Alamofire.request(resourceURL, method: .post, parameters: userToSave.getDictChangePass(), encoding: JSONEncoding.default, headers: userToSave.getDictToken()).responseData{ response in
            switch response.result{
                    
                case .success(let data):
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        
                        if response.response?.statusCode == 200 {
                            
                            print(json)
                            
                            completion(.success(userToSave))
                        }else{
                            print(json)
                            completion(.failure(APIError.responseProblem))
                        }
                    }catch{
                        //let json = try JSONSerialization.jsonObject(with: data, options: [])
                        
                        if let headers = response.response?.allHeaderFields as? [String: String]{
                           let header = headers["token"]
                            print(header)
                        }
                        print(response.response!.statusCode)
                        
                        print(userToSave.getDictToken())
                        
                        print("Usuario o contraseña incorrectas")
                        
                        completion(.failure(APIError.decodingProblem))
                    }
                    
                case .failure(_):
                    //print(err.localizedDescription)
                    completion(.failure(APIError.responseProblem))
                }
            }
        }
        
        
    
    func getRoutes(_ Route: Route, completion: @escaping(Swift.Result<Route,Error>)->Void){
        
        Alamofire.request(resourceURL, method: .post, parameters: Route.getDictRoute(), encoding: JSONEncoding.default, headers: nil).responseData{ response in
            switch response.result{
                    
                case .success(let data):
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        
                        let jsonObject = json as! NSArray
                        
                        if response.response?.statusCode == 200 {
                        
//
//                            print(json)
//
//                            print(jsonObject[0])
                            
                            if let array = json as? [[String: Any]] {

                                let altitudeArray = array.compactMap{ $0["altitude"] as? String}
                                let latitudeArray = array.compactMap{ $0["latitude"] as? String}

                                
                                
                                UserDefaults.standard.set(altitudeArray, forKey: altitude)
                                UserDefaults.standard.set(latitudeArray, forKey: longitude)
                                
                                UserDefaults.standard.synchronize()
                                
//                                print(altitudeArray[0])
//                                print(latitudeArray[0])
                            }
                            
                            

//                            if let json = json as? [String: String] {
//                                let tokenJSON = json["latitude"]
//
//                                print(tokenJSON)
//
//                               UserDefaults.standard.set(tokenJSON, forKey: token)
//                               UserDefaults.standard.synchronize()
//
//                            }
                            
                            completion(.success(Route))
                        }else{
                            print(json)
                            completion(.failure(APIError.responseProblem))
                        }
                    }catch{
                        print(response.response!.statusCode)
                        
                        print("Usuario o contraseña incorrectas")
                        
                        completion(.failure(APIError.decodingProblem))
                    }
                    
                case .failure(_):
                    completion(.failure(APIError.responseProblem))
                }
            }
        }
    
        
    }
    
        

