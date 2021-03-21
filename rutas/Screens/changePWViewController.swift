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
    @IBOutlet weak var currentPassField: UITextField!
    @IBOutlet weak var changePW: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        changePW.layer.cornerRadius = 30
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
    
    
    @IBAction func settingsButton(_ sender: Any) {
        
        self.dismiss(animated:true, completion: nil) // Destruir la pantalla anterior.
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "settingsVC") as! settingsViewController
                
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true)
        
    }
    
    
    @IBAction func changePass(_ sender: Any) {
        
        buttonAnimation(sender: changePW) // Animación del botón
                    
        let emailText = emailField.text!
        let currentPassText = currentPassField.text!
        let passText = passField.text!
                    
                //let user = User(email: emailText, name: userText, password: passText)
                
        let user = User(name: "", email: emailText, password: passText, currentPassword: currentPassText)
                
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
        
        self.dismiss(animated:true, completion: nil) // Destruir la pantalla anterior.
    }
    
    // Deshabilitar teclado.
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}
