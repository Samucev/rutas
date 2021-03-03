//
//  ViewController.swift
//  rutas
//
//  Created by alumnos on 21/01/2021.
//  Copyright © 2021 alumnos. All rights reserved.
//

import UIKit

class registerViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    

    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var confirmPassField: UITextField!
    @IBOutlet weak var passField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        signInButton.layer.cornerRadius = 30 // Botón redondeado
        
    }
    
    // Animación del botón.
    
    func buttonAnimation(sender:UIButton) {
        
        print("Botón animado.")
        self.animatedView(sender)
        
    }
    
    func animatedView(_ viewToAnimate:UIView) {
        
        UIView.animate(withDuration: 0.1, animations: {
            
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.80, y: 0.80)
            
        }) { (_) in
            
            
            UIView.animate(withDuration: 0.1, animations: {
                
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
                
            }, completion: nil)
            
        }
        
    }
    
    /* BOTÓN PARA VOLVER A LA PANTALLA DE LOGIN */
    
    @IBAction func signInButton(_ sender: Any) {
        
        buttonAnimation(sender: signInButton) // Animación del botón
        
        // API.
        
        if passField.text! != confirmPassField.text! {
            print("contraseñas incorrectas")
            return
        }else{
            
            let userText = userField.text!
            let emailText = emailField.text!
            let passText = passField.text!
            
        //let user = User(email: emailText, name: userText, password: passText)
        
            let user = User(name: userText, email: emailText, password: passText, currentPassword: "")
        
        //let postRequest = APIManager(endpoint: "api/register")
        let postRequest = APIManager(endpoint: "users/create")
            
            //let postRequest = APIRequest(endpoint: "users/create")
            
        postRequest.register(user, completion: {result in
                switch result{
                case .success(let user):
                    
                    

                    
                    // Navegación de pantalla.
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(identifier: "VC") as! loginViewController
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true)
                    
                    print("El siguiente usuario ha sido creado:\(user.email) ")
                    case .failure(let error):
                    
                    print("Ha ocurrido un error \(error)")

                }
            })
            
            self.dismiss(animated:true, completion: nil) // Destruir la pantalla anterior.
            
        }
        
        
        
        
        
    }
    


}
