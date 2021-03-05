




//
//  ViewController.swift
//  mapaP
//
//  Created by Apps2m on 27/01/2021.
//  Copyright © 2021 Apps2m. All rights reserved.
//

    import UIKit
    import MapKit
    import CoreLocation
    

@available(iOS 13.0, *)
class mapViewController: UIViewController {
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var profileButton: UIButton!
    
    @IBOutlet weak var infoButton: UIButton!
    
    @IBOutlet weak var cameraButton: UIButton!
    
        @IBOutlet weak var mapa: MKMapView!
        @IBOutlet weak var nombreP: UILabel!
        var locationManager = CLLocationManager()
           var bol = true
        
      
       let latitud = 40.4345306
       let altitud = -3.7190748
        
        
        
    
    
   
        
        override func viewDidLoad() {
            super.viewDidLoad()
          
            mapa.showsUserLocation = true
            self.mapa.delegate = self
            self.locationManager.requestAlwaysAuthorization()

            mapa.setUserTrackingMode(.followWithHeading, animated: true)
            self.checkLocationAuthorization()
            self.locationManager.requestWhenInUseAuthorization()


            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()

            }
            
            let altituded = UserDefaults.standard.array(forKey: altitude)
            let hoff = "hola"
            
           //print(altituded![0])
            print("hola" + hoff)
            
          if let altitude = UserDefaults.standard.string(forKey: altitude){

                print(altitude)
            }else{
                print("no hay datos")
            }
     
            
          // https://www.adictosaltrabajo.com/2017/08/16/geofences-en-ios-swift/
          // https://stackoverflow.com/questions/55985353/why-does-user-location-in-mkmapview-shows-latitude-0-0-and-longitude-0-0
          let punto = MKPointAnnotation()
          //madrid
          punto.coordinate = CLLocationCoordinate2D(latitude: 40.4167, longitude: -3.70325 )
          mapa.addAnnotation(punto)
         
       
           locationManager.distanceFilter = 525

                 let geoFenceRegion:CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2DMake(40.4345306,-3.7190748), radius: 525, identifier: "Boise")

                 locationManager.startMonitoring(for: geoFenceRegion)
                 let coordenadasCirculo = CLLocationCoordinate2D(latitude: 40.4345306, longitude: -3.7190748)
                 let radio = CLLocationDistance(525)

                 showCircle(coordinate: coordenadasCirculo, radius: radio)

//            // Redondeo de Botones
//
            settingsButton.layer.cornerRadius = 25

            profileButton.layer.cornerRadius = 25

            infoButton.layer.cornerRadius = 25

            cameraButton.layer.cornerRadius = 25
   
        
    }
    
    @IBAction func mapSettingsButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: "mapSettingsVC") as! mapSettingsViewController
                
        /*vc.modalPresentationStyle = .overFullScreen*/
        
        present(vc, animated: true)
        

    }
    
    
    
    @IBAction func profileButton(_ sender: Any) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let vc = storyboard.instantiateViewController(identifier: "profileVC") as! profileViewController

        /*vc.modalPresentationStyle = .overFullScreen*/

        present(vc, animated: true)

    }


    @IBAction func infoButton(_ sender: Any) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let vc = storyboard.instantiateViewController(identifier: "infoVC") as! infoViewController

        /*vc.modalPresentationStyle = .overFullScreen*/

        present(vc, animated: true)

    }


    @IBAction func cameraButton(_ sender: Any) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let vc = storyboard.instantiateViewController(identifier: "cameraVC") as! cameraViewController

        vc.modalPresentationStyle = .overFullScreen

        present(vc, animated: true)

    }


   //entrar en la zona
      public  func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
          print("Entered: \(region.identifier)")


          guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
                 print("locations = \(locValue.latitude) \(locValue.longitude)")
                 // coordenadas del usuario
        self.mapa.removeOverlays(self.mapa.overlays)
                 let sourceLocation = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
                 let destinationLocation = CLLocationCoordinate2D(latitude: latitud , longitude: altitud)

                 createPath(sourceLocation: sourceLocation, destinationLocation: destinationLocation, bol: bol)



      }



    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        // coordenadas del usuario
        let sourceLocation = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        let destinationLocation = CLLocationCoordinate2D(latitude: 40.4207500 , longitude: -3.7517500)

        createPath(sourceLocation: sourceLocation, destinationLocation: destinationLocation, bol: bol)


    }

    //salir de la zona

        func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Exited: \(region.identifier)")
        self.nombreP.text = "hola"




                   // Fallback on earlier versions

          self.bol = false
        print(bol)

        //
    }



    func showCircle(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance){
         let circle = MKCircle(center: coordinate, radius: radius)
         mapa.addOverlay(circle)

     }




     func createPath(sourceLocation : CLLocationCoordinate2D, destinationLocation : CLLocationCoordinate2D, bol: Bool) {



             let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
             let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
             let sourceMapItem = MKMapItem(placemark: sourcePlaceMark)
             let destinationItem = MKMapItem(placemark: destinationPlaceMark)
             let directionRequest = MKDirections.Request()
             directionRequest.source = sourceMapItem
             directionRequest.destination = destinationItem
             directionRequest.transportType = .walking

             let direction = MKDirections(request: directionRequest)


             direction.calculate { (response, error) in
                 guard let response = response else {
                     if let error = error {
                         print("ERROR FOUND : \(error.localizedDescription)")
                     }
                     return
                 }

                 let route = response.routes[0]
                 self.mapa.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)

                 let rect = route.polyline.boundingMapRect

            }


         }
   func mapView(_ mapView: MKMapView!, rendererFor overlay: MKOverlay!) -> MKOverlayRenderer! {


       if overlay is MKPolyline{

           let rendere = MKPolylineRenderer(overlay: overlay )
                  rendere.lineWidth = 3
                  rendere.strokeColor = .systemRed

                  return rendere

       }
    if overlay is MKCircle{

              let circleRenderer = MKCircleRenderer(overlay: overlay)
              circleRenderer.fillColor = .blue
              circleRenderer.alpha = 0.3

              return circleRenderer

          }


               return nil
   }

    func checkLocationAuthorization(authorizationStatus: CLAuthorizationStatus? = nil) {
        switch (authorizationStatus ?? CLLocationManager.authorizationStatus()) {
        case .authorizedAlways, .authorizedWhenInUse:
        mapa.showsUserLocation = true
        case .notDetermined:

            if locationManager == nil {
                locationManager = CLLocationManager()
                locationManager.delegate = self
            }
            locationManager.requestWhenInUseAuthorization()

        default:
            print("Location Servies: Denied / Restricted")
        }
    }

    func setupLocationManager() {
               locationManager.delegate = self
               locationManager.desiredAccuracy = kCLLocationAccuracyBest
           }


    func centerViewOnUserLocation() {
               if let location = locationManager.location?.coordinate {

               }
           }


    func checkLocationServices() {
               if CLLocationManager.locationServicesEnabled() {
                   setupLocationManager()
                   checkLocationAuthorization()
               } else {
                   // Show alert letting the user know they have to turn this on.
               }
           }


    func checkLocationAuthorization() {
               switch CLLocationManager.authorizationStatus() {
               case .authorizedWhenInUse:
                   mapa.showsUserLocation = true
                   centerViewOnUserLocation()
                   locationManager.startUpdatingLocation()
                   break
               case .denied:
                   // Show alert instructing them how to turn on permissions
                   break
               case .notDetermined:
                   locationManager.requestWhenInUseAuthorization()
               case .restricted:
                   // Show an alert letting them know what's up
                   break
               case .authorizedAlways:
                   break
               }
           }


}
@available(iOS 13.0, *)
extension mapViewController: MKMapViewDelegate, CLLocationManagerDelegate {

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)

    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.checkLocationAuthorization(authorizationStatus: status)

    }

}


