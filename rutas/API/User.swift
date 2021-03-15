//
//  User.swift
//  rutas
//
//  Created by alumnos on 26/01/2021.
//  Copyright © 2021 alumnos. All rights reserved.
//

import Foundation

//struct User: Decodable {
//    let email: String
//    let password: String
//}

struct User: Encodable{
    var id: Int?
    let name: String
    let email: String
    let password: String
    let currentPassword: String
    
    init(name: String, email: String, password: String, currentPassword: String) {
        self.name = name
        self.email = email
        self.password = password
        self.currentPassword = currentPassword
    }
    
    func getDictRegister() -> [String:String] {
        return ["name":name, "email":email, "password": password]
    }
    
    func getDictRegisterApi() -> [String:String] {
        return ["user":name, "email":email, "pass": password]
    }
    
    func getDictLogin() -> [String:String] {
        return ["email":email, "password": password]
    }
    
    func getDictChangePass() -> [String:String] {
        return ["email":email, "newPassword": password, "currentPassword": currentPassword]
    }
    
    func getDictToken()->[String:String]{
        
        if let token = UserDefaults.standard.string(forKey: token){
            return["Authorization":token]
        }else{
            return["Authorization":"No hay token"]
        }
    }
    
    
}
