//
//  ViewController.swift
//  rutas
//
//  Created by alumnos on 21/01/2021.
//  Copyright © 2021 alumnos. All rights reserved.
//

import UIKit

class recoverPWViewController: UIViewController {
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loginButton.layer.cornerRadius = 30
        
    }

    /* BOTÓN PARA VOLVER A LA PANTALLA DE LOGIN */
    
    @IBAction func loginButton(_ sender: Any) {
        
        self.dismiss(animated:true, completion: nil)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: "VC") as! loginViewController
                
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true)
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
