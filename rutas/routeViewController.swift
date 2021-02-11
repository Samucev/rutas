//
//  ViewController.swift
//  rutas
//
//  Created by alumnos on 21/01/2021.
//  Copyright © 2021 alumnos. All rights reserved.
//

import UIKit

class routeViewController: UIViewController {
    
    
    @IBOutlet weak var profileButton: UIButton!
    
    
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        profileButton.layer.cornerRadius = 30
        
        settingsButton.layer.cornerRadius = 30
        
    }

    
    
    
    @IBAction func profileButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: "profileVC") as! profileViewController
                
        /*vc.modalPresentationStyle = .overFullScreen*/
        
        present(vc, animated: true)
        
    }
    
    
    @IBAction func settingsButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: "settingsVC") as! settingsViewController
                
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true)
        
    }
    
    
    @IBAction func mapButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: "mapVC") as! mapViewController
                
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true)
        
    }
    

}
