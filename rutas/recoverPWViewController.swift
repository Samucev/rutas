//
//  ViewController.swift
//  rutas
//
//  Created by alumnos on 21/01/2021.
//  Copyright © 2021 alumnos. All rights reserved.
//

import UIKit

class recoverPWViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    /* BOTÓN PARA VOLVER A LA PANTALLA DE LOGIN */
    
    @IBAction func loginButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: "VC") as! loginViewController
                
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true)
        
    }
    
}
