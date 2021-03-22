//
//  mapSettingsViewController.swift
//  rutas
//
//  Created by Apps2m on 08/02/2021.
//  Copyright © 2021 alumnos. All rights reserved.
//

import UIKit

class mapSettingsViewController: UIViewController {
    
    
    @IBOutlet weak var routeListButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        routeListButton.layer.cornerRadius = 30
    }
    
    
    @IBAction func routeListButton(_ sender: Any) {
        

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "routeVC") as! routeViewController
                
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true)
        
        
        
    }
    

    

}
