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
    @IBOutlet weak var madridOculto: UIButton!
    @IBOutlet weak var guerraCivil: UIButton!
    @IBOutlet weak var madridAustrias: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        profileButton.layer.cornerRadius = 30
        settingsButton.layer.cornerRadius = 30
        madridOculto.layer.cornerRadius = 30
        guerraCivil.layer.cornerRadius = 30
        madridAustrias.layer.cornerRadius = 30
        
        
        
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

    
    
    
    @IBAction func profileButton(_ sender: Any) {
        
        buttonAnimation(sender: profileButton) // Animación del botón
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "profileVC") as! profileViewController
                
        //vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true)
        
    }
    
    
    @IBAction func settingsButton(_ sender: Any) {
        
        buttonAnimation(sender: settingsButton) // Animación del botón
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "settingsVC") as! settingsViewController
                
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true)
        
    }
    
    
    @available(iOS 13.0, *)
    @IBAction func mapButton(_ sender: Any) {
        
        
        
        let route = Route(name: "Madridf")
                
                //let postRequest = APIManager(endpoint: "api/register")
        let postRequest = APIManager(endpoint: "coordinates/list")
                    
                    //let postRequest = APIRequest(endpoint: "users/create")
                    
        postRequest.getRoutes(route, completion: {result in
            switch result{
                case .success(let route):
                            
                    print("El siguiente usuario ha sido enviado:\(route.name) ")
                            
                case .failure(let error):
                            
                    print("Ha ocurrido un error \(error)")

            }
        })
        
        buttonAnimation(sender: madridOculto) // Animación del botón
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let vc = storyboard.instantiateViewController(withIdentifier: "mapVC") as! mapViewController

        vc.modalPresentationStyle = .overFullScreen

        present(vc, animated: true)
        
    }
    

}
