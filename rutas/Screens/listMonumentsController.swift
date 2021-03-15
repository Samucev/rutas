//
//  listMonumentsController.swift
//  rutas
//
//  Created by alumnos on 09/03/2021.
//  Copyright © 2021 alumnos. All rights reserved.
//

import Foundation
import UIKit

class listMonumentsViewController: UIViewController, UITableViewDelegate {

    


    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var celda: UIView!
    

    let nameArray = UserDefaults.standard.array(forKey: name)
    //var users1 : [String] = []
    var nameMonuments = [String]()
    var hola = ["cibeles", "neptuno","leones del congreso","oso y modroño"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
       
       // nameMonuments = nameArray.map{$0 as! [String]}!
        
        print(nameMonuments)
        //print(users1)
    }
    
    
    
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         var ubia = tableView.indexPathForSelectedRow
        print(tableView.indexPathForSelectedRow)

        
        
         print(self.hola[indexPath.row])

         
     }
}

extension listMonumentsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hola.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMonument", for: indexPath)

        //print(users1)

        cell.textLabel?.text = hola[indexPath.row]

        
    
        //click evet
        
        
    
     
        //var nombrepresionado =  cell
        
        return cell
        
        

    }
    
    
}
