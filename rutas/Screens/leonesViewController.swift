//
//  leonesViewController.swift
//  rutas
//
//  Created by Apps2m on 22/03/2021.
//  Copyright © 2021 alumnos. All rights reserved.
//

import UIKit

class leonesViewController: UIViewController {

    
    @IBOutlet weak var mapButton: UIButton!

    override func viewDidLoad() {

        super.viewDidLoad()

       mapButton.layer.cornerRadius = 30
        

    }
    
    @IBAction func mapButton(_ sender: Any) {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "cameraVC") as! cameraViewController
                
        //vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true)
        
    }


}
