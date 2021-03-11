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
public var name = "NAME_KEY"





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

<<<<<<< HEAD
    func register(_ userToSave: User ,completion: @escaping(Swift.Result<User,Error>, String?)->Void){
=======


    func register(_ userToSave: User ,completion: @escaping(Swift.Result<User,Error>, String?)->Void){

>>>>>>> ca0677cf60fa8375c4dbf828d99bed3db05e19c8
        

        

        Alamofire.request(resourceURL, method: .post, parameters: userToSave.getDictRegister(), encoding: JSONEncoding.default, headers: nil).responseData{ response in

            switch response.result{

                    

                case .success(let data):

                    

                    do{

                        

                        let json = try JSONSerialization.jsonObject(with: data, options: [])

                        

                        if response.response?.statusCode == 200 {

                            
<<<<<<< HEAD
                            if let json = json as? [String: String?] {
                                let noPermission = json["message"]
                                
                                print("hola")
                                print(noPermission)

                                completion(.success(userToSave), noPermission!)
                                return
=======

                            if let json = json as? [String: String?] {

                                let noPermission = json["message"]

                                

                                print("hola")

                                print(noPermission)



                                completion(.success(userToSave), noPermission!)

                                return

>>>>>>> ca0677cf60fa8375c4dbf828d99bed3db05e19c8
                            }

                            
<<<<<<< HEAD
                            completion(.success(userToSave), nil)
                            
                            print(json)
=======

                            completion(.success(userToSave), nil)

                            

                            print(json)

>>>>>>> ca0677cf60fa8375c4dbf828d99bed3db05e19c8
//

//                            print("El usuario " + userToSave.name + " ha sido creado")

//

                            

                        }else{

                            print("No se ha podido crear el usuario")



                        }

                        

                        

                    }catch{

                        

                        print(response.response!.statusCode)

                        

                        print("Usuario o contraseña incorrectas")

                        
<<<<<<< HEAD
                        completion(.failure(APIError.decodingProblem),nil)
=======

                        completion(.failure(APIError.decodingProblem),nil)

>>>>>>> ca0677cf60fa8375c4dbf828d99bed3db05e19c8
                    }

                    
                    
<<<<<<< HEAD
                case .failure(let data):
                    
                    print(data)
                    //print(err.localizedDescription)
                    completion(.failure(APIError.responseProblem),nil)
=======

                case .failure(let data):

                    

                    print(data)

                    //print(err.localizedDescription)

                    completion(.failure(APIError.responseProblem),nil)

>>>>>>> ca0677cf60fa8375c4dbf828d99bed3db05e19c8
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

                        
<<<<<<< HEAD
                        //let jsonObject = json as! NSArray
=======

                        let jsonObject = json as! NSArray

>>>>>>> ca0677cf60fa8375c4dbf828d99bed3db05e19c8
                        

                        if response.response?.statusCode == 200 {

                        

//

//                            print(json)

//

//                            print(jsonObject[0])

                            

                            if let array = json as? [[String: Any]] {



                                let altitudeArray = array.compactMap{ $0["altitude"] as? String}

                                let latitudeArray = array.compactMap{ $0["latitude"] as? String}
                                let nameArray = array.compactMap{ $0["name"] as? String}



                                

                                

                                UserDefaults.standard.set(altitudeArray, forKey: altitude)

                                UserDefaults.standard.set(latitudeArray, forKey: longitude)
<<<<<<< HEAD
                                UserDefaults.standard.set(nameArray, forKey: name)
=======

>>>>>>> ca0677cf60fa8375c4dbf828d99bed3db05e19c8
                                

                                UserDefaults.standard.synchronize()

                                
<<<<<<< HEAD
                     //           print(altitudeArray)
               //                 print(latitudeArray)
                                print(nameArray)
//                                print(json)
=======

//                                print(altitudeArray[0])

//                                print(latitudeArray[0])

>>>>>>> ca0677cf60fa8375c4dbf828d99bed3db05e19c8
                            }

                            

                            
<<<<<<< HEAD
=======



//                            if let json = json as? [String: String] {

//                                let tokenJSON = json["latitude"]

//

//                                print(tokenJSON)

//

//                               UserDefaults.standard.set(tokenJSON, forKey: token)

//                               UserDefaults.standard.synchronize()

//

//                            }

                            

>>>>>>> ca0677cf60fa8375c4dbf828d99bed3db05e19c8
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
    
        

