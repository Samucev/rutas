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
    
    // Animación del botón.

    func buttonAnimation(sender:UIButton) {

        print("Botón animado.")

        self.animatedView(sender)

    }


    func animatedView(_ viewToAnimate:UIView) {

        UIView.animate(withDuration: 0.1, animations: {

            viewToAnimate.transform = CGAffineTransform(scaleX: 0.80, y: 0.80)}) { (_) in

            UIView.animate(withDuration: 0.1, animations: {

                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)

            }, completion: nil)

        }

    }

    
    
    
    /* BOTÓN DE LOGIN */
    
    
    @IBAction func routeListButton(_ sender: Any) {
        
        buttonAnimation(sender: loginButton) //Animación del botón
        
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
    
    // Deshabilitar teclado.
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}

