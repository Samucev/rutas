//
//  Circle.swift
//  rutas
//
//  Created by user177575 on 3/22/21.
//  Copyright © 2021 alumnos. All rights re


import Foundation


struct Circle: Encodable{
    let id: String
    

    init(id: String) {
        self.id = id

    }

    func getDictRoute() -> [String:String] {
        return ["id":id]
    }
}
