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

    func register(_ userToSave: User, completion: @escaping(Swift.Result<User,Error>)->Void){
        
        
        Alamofire.request(resourceURL, method: .post, parameters: userToSave.getDictRegister(), encoding: JSONEncoding.default, headers: nil).responseData{ response in
            switch response.result{
                    
                case .success(_):
                    
                    if response.response?.statusCode == 200 {
                        
                        print("El usuario " + userToSave.name + " ha sido creado")

                        completion(.success(userToSave))
                    }else{
                        print("No se ha podido crear el usuario")

                    }
                    
                    
                case .failure(_):
                    //print(err.localizedDescription)
                    completion(.failure(APIError.responseProblem))
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
                               // now you have a top-level json dictionary
                                //print(json["token"]!)
                                
                                let tokenJSON = json["token"]
                                
                                UserDefaults.standard.set(tokenJSON, forKey: token)
                                UserDefaults.standard.synchronize()
                                
//                                if let value = UserDefaults.standard.string(forKey: "TOKEN_KEY"){
//                                    print(value)
//                                }else{
//                                    print("No hay nada")
//                                }
                                
                                //let tokenUser = User(name: "", email: "", password: "", token: self.token)
                                

                            }
                            
                            completion(.success(userToSave))
                        }else{
                            print(json)
                            completion(.failure(APIError.responseProblem))
                        }
                    }catch{
                        //let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(response.response!.statusCode)
                        
                        print("Usuario o contraseña incorrectas")
                        
                        completion(.failure(APIError.decodingProblem))
                    }
                    
                case .failure(_):
                    //print(err.localizedDescription)
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
        
        
        
    }
    
        

