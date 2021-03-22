//
//  Circle.swift
//  rutas
//
//  Created by user177575 on 3/22/21.
//  Copyright © 2021 alumnos. All rights re


import Foundation


struct Circle: Encodable{
    let id: Int
    

    init(id: Int) {
        self.id = id

    }

    func getDictRoute() -> [String:Int] {
        return ["id":id]
    }
}
