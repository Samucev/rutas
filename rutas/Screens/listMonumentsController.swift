//
//  listMonumentsController.swift
//  rutas
//
//  Created by alumnos on 09/03/2021.
//  Copyright © 2021 alumnos. All rights reserved.
//

import Foundation
import UIKit
public var nombref = String()
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

            
            var nombref  = tableView.cellForRow(at: indexPath)?.textLabel?.text
            
            let monument = Monument(name: nombref!)
            
            let postRequest = APIManager(endpoint: "monuments/list")
            
            

            postRequest.getMonumets(monument, completion: {result in
                switch result{
                case .success(_):
                    print("Se ha obtenido la información ")
                case .failure(let error):
                    print("Ha ocurrido un error \(error)")
                }
            })
            
            print(info)
            
            
            
            if nombref ==  "cibeles" {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
               
                let vc = storyboard.instantiateViewController(withIdentifier: "cibelesvc") as! recoverPWViewController
                       
                vc.modalPresentationStyle = .overFullScreen
               
                present(vc, animated: true)
                }
            if nombref ==  "neptuno" {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
               
                let vc = storyboard.instantiateViewController(withIdentifier: "neptunovc") as! recoverPWViewController
                       
                vc.modalPresentationStyle = .overFullScreen
               
                present(vc, animated: true)
                }
            
            if nombref ==  "leones" {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
               
                let vc = storyboard.instantiateViewController(withIdentifier: "leonesvc") as! recoverPWViewController
                       
                vc.modalPresentationStyle = .overFullScreen
               
                present(vc, animated: true)
                }
            if nombref ==  "oso" {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
               
                let vc = storyboard.instantiateViewController(withIdentifier: "osovc") as! recoverPWViewController
                       
                vc.modalPresentationStyle = .overFullScreen
               
                present(vc, animated: true)
                }


            //--------------------
           /*
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
           
            let vc = storyboard.instantiateViewController(withIdentifier: "recoverPWCV") as! recoverPWViewController
                   
            vc.modalPresentationStyle = .overFullScreen
           
            present(vc, animated: true)
            //self.dismiss(animated:true, completion: nil)
            
 */
            
            
//            print(arrayMonumentsFinal[indexPath.row])

             
         }
    }

    extension listMonumentsViewController: UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrayMonumentsFinal.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellMonument", for: indexPath)

            //print(users1)

            cell.textLabel?.text = arrayMonumentsFinal [indexPath.row]

            
        
            //click evet
            
            
        
         
            //var nombrepresionado =  cell
            
            return cell
            
            

        }
        
        
        override func viewDidAppear(_ animated: Bool) {
            //presentingViewController?.dismiss(animated: false, completion: nil)
            let vc = UIApplication.shared.keyWindow?.rootViewController
            
            vc?.dismiss(animated: true, completion: nil)
            print("hola")
        }
        
    }
