//
//  ViewController.swift
//  rutas
//
//  Created by alumnos on 21/01/2021.
//  Copyright © 2021 alumnos. All rights reserved.
//

import UIKit

class changePWViewController: UIViewController {
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var confirmPassField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func settingsButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: "settingsVC") as! settingsViewController
                
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true)
        
    }
    
    
    @IBAction func changePass(_ sender: Any) {
        
        
        
        if passField.text! != confirmPassField.text! {
            print("contraseñas incorrectas")
            return
        }else{
            
            let emailText = emailField.text!
            let passText = passField.text!
                    
                //let user = User(email: emailText, name: userText, password: passText)
                
                let user = User(name: "", email: emailText, password: passText)
                
                //let postRequest = APIManager(endpoint: "api/register")
                let postRequest = APIManager(endpoint: "users/update")
                    
                    //let postRequest = APIRequest(endpoint: "users/create")
                    
                postRequest.changePass(user, completion: {result in
                        switch result{
                        case .success(let user):
                            
                            print("El siguiente usuario ha sido enviado:\(user.email) ")
                            
                        case .failure(let error):
                            
                            print("Ha ocurrido un error \(error)")

                        }
                    })
            }
    }
    

}
