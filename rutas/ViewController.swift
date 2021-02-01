//
//  ViewController.swift
//  rutas
//
//  Created by alumnos on 21/01/2021.
//  Copyright © 2021 alumnos. All rights reserved.
//

import UIKit




class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                              
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    

    @IBAction func loginButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "routeVC") as! routeViewController
        present(vc, animated: true)
    }
    
    
    /*func goToRoutes(){
        
        let vc = storyboard?.instantiateViewController(identifier: "routesVC") as! routeViewController
        present(vc, animated: true)
        
    }*/


}

