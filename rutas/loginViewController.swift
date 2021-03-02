//
//  ViewController.swift
//  rutas
//
//  Created by alumnos on 21/01/2021.
//  Copyright © 2021 alumnos. All rights reserved.
//

import UIKit


class loginViewController: UIViewController {
    
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var visualEffect: UIVisualEffectView!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loginButton.layer.cornerRadius = 30
                                      
    }
    
    
    
    /* BOTÓN DE LOGIN */
    
    
    @IBAction func routeListButton(_ sender: Any) {
        
        let pass = passwordTextField.text!
        let email = emailTextField.text!
        
        let user = User(name: "", email: email, password: pass, currentPassword: "")
        
        let postRequest = APIManager(endpoint: "users/login")

        postRequest.login(user, completion: {result in
            switch result{
            case .success(let user):
        
                
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                let vc = storyboard.instantiateViewController(identifier: "routeVC") as! routeViewController
                        
                vc.modalPresentationStyle = .overFullScreen
                
                self.present(vc, animated: true)
        
                
                
                print("El siguiente usuario ha inciado sesión:\(user.email) ")
            case .failure(let error):
                print("Ha ocurrido un error \(error)")
            }
        })
        

        
    }
    
    /* BOTÓN DE REGISTRO */
        
    @IBAction func registerButton(_ sender: Any) {
        
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: "registerVC") as! registerViewController
                
        /*vc.modalPresentationStyle = .overFullScreen*/
        
        present(vc, animated: true)
        
        
    }
    
    
    /* BOTÓN DE RECUPERAR CONTRASEÑA */
    
   
    @IBAction func recoverPWButton(_ sender: Any) {
        
                
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: "recoverPWCV") as! recoverPWViewController
                
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true)
        
        
    }
    

}

