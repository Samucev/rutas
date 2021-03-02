//
//  Route.swift
//  rutas
//
//  Created by alumnos on 02/03/2021.
//  Copyright © 2021 alumnos. All rights reserved.
//

import Foundation


struct Route: Encodable{
    var id: Int?
    let name: String

    init(name: String) {
        self.name = name

    }

    func getDictRoute() -> [String:String] {
        return ["name":name]
    }
}
