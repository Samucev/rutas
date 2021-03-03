//
//  ViewController.swift
//  rutas
//
//  Created by alumnos on 21/01/2021.
//  Copyright © 2021 alumnos. All rights reserved.
//

import UIKit

class settingsViewController: UIViewController {
    
    
    @IBOutlet weak var privacyButton: UIButton!
    @IBOutlet weak var changePWButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        privacyButton.layer.cornerRadius = 30
        changePWButton.layer.cornerRadius = 30
        signOutButton.layer.cornerRadius = 30
        
    }
    
    
    @IBAction func routeListButton(_ sender: Any) {
        
        self.dismiss(animated:true, completion: nil) // Destruir la pantalla anterior.
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: "routeVC") as! routeViewController
                
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true)
        
    }
    
    
    @IBAction func changePWButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: "changePWVC") as! changePWViewController
                
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true)
        
    }
    
    
    
    @IBAction func signOutButton(_ sender: Any) {
        
        
        
        let alert = UIAlertController(title: "Cerrar sesión", message: "¿Estás seguro de que quieres cerrar sesión?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cerrar Sesión", style: .default, handler: { action in
            
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let vc = storyboard.instantiateViewController(identifier: "VC") as! loginViewController
                    
            vc.modalPresentationStyle = .overFullScreen
            
            self.present(vc, animated: true)
            
            
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))

        self.present(alert, animated: true)
        
        
        
    }
    

}
