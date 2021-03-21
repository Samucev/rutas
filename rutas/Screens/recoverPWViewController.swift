//
//  ViewController.swift
//  rutas
//
//  Created by alumnos on 21/01/2021.
//  Copyright © 2021 alumnos. All rights reserved.
//

import UIKit

class recoverPWViewController: UIViewController {
    
    
    @IBOutlet weak var recoverPWButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        recoverPWButton.layer.cornerRadius = 30
        
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
    
    

    /* BOTÓN PARA VOLVER A LA PANTALLA DE LOGIN */
    
    @IBAction func loginButton(_ sender: Any) {
        
        self.dismiss(animated:true, completion: nil)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "VC") as! loginViewController
                
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true)
        
    }
    
    /* BOTÓN PARA RECUPERAR CONTRASEÑA */
    
    
    @IBAction func recoverPWButton(_ sender: Any) {
        
        // Función para recuperar contraseña :v
        
        buttonAnimation(sender: recoverPWButton) // Animación del botón
        
    }
    
    
    // Deshabilitar teclado.
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
