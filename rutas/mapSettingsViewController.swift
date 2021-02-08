//
//  mapSettingsViewController.swift
//  rutas
//
//  Created by Apps2m on 08/02/2021.
//  Copyright © 2021 alumnos. All rights reserved.
//

import UIKit

class mapSettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func routeListButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: "routeVC") as! routeViewController
                
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true)
        
    }
    

    

}
