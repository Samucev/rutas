//
//  Monument.swift
//  rutas
//
//  Created by alumnos on 23/03/2021.
//  Copyright © 2021 alumnos. All rights reserved.
//

import Foundation


struct Monument: Encodable{
    let name: String
    
    init(name: String) {
        self.name = name

    }

    func getDictRoute() -> [String:String] {
        return ["name":name]
    }
}
