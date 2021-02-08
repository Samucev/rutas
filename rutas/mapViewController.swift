




import UIKit
import MapKit
import CoreLocation

class mapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapa: MKMapView!
    let locationManager = CLLocationManager()
        let regionInMeters: Double = 100000
    var mapView = MKMapView()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            checkLocationServices()
            let punto = MKPointAnnotation()
            //madrid
            punto.coordinate = CLLocationCoordinate2D(latitude: 40.4167, longitude: -3.70325 )
            mapa.addAnnotation(punto)
            
                    let sourceLocation = CLLocationCoordinate2D(latitude: 40.4167, longitude: -3.70325)
                    let destinationLocation = CLLocationCoordinate2D(latitude: 40.4207500 , longitude: -3.7517500)
                    let coordenadasCirculo = CLLocationCoordinate2D(latitude: 40.4167, longitude: -3.70325)
                    let radio = CLLocationDistance(1000)
            
                
            
            showCircle(coordinate: coordenadasCirculo, radius: radio)
            
            
             
            
          createPath(sourceLocation: sourceLocation, destinationLocation: destinationLocation)
            
                    
            self.mapa.delegate = self
                
                
            
            
            
        }
    
    /* BOTONES DEL MAPA */
    
    ///
    
    
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
    
    
    
    
    ///
    
    func showCircle(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance){
        let circle = MKCircle(center: coordinate, radius: radius)
        
                mapa.addOverlay(circle)
        
    }
    
    
    
   
   
    func createPath(sourceLocation : CLLocationCoordinate2D, destinationLocation : CLLocationCoordinate2D) {
            let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
            let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
            
            
            let sourceMapItem = MKMapItem(placemark: sourcePlaceMark)
            let destinationItem = MKMapItem(placemark: destinationPlaceMark)
            
            
            let sourceAnotation = MKPointAnnotation()
            sourceAnotation.title = "Madrid"
            if let location = sourcePlaceMark.location {
                sourceAnotation.coordinate = location.coordinate
            }

            let destinationAnotation = MKPointAnnotation()
            destinationAnotation.title = "Campo"
            if let location = destinationPlaceMark.location {
                destinationAnotation.coordinate = location.coordinate
            }

            self.mapa.showAnnotations([sourceAnotation, destinationAnotation], animated: true)
            
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
                
                self.mapa.setRegion(MKCoordinateRegion(rect), animated: true)
                
            }
        }
     
    
     

    
    
    
        
        
        func setupLocationManager() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        
        
        func centerViewOnUserLocation() {
            if let location = locationManager.location?.coordinate {
                let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
                mapa.setRegion(region, animated: true)
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
      func mapView(_ mapView: MKMapView!, rendererFor overlay: MKOverlay!) -> MKOverlayRenderer! {
                
                
                
                    // If you want to include other shapes, then this check is needed.
                    // If you only want circles, then remove it.
                    
                if overlay is MKPolyline{
                    let rendere = MKPolylineRenderer(overlay: overlay)
                    rendere.lineWidth = 3
                    rendere.strokeColor = .systemRed

                    return rendere
                    
                }
                        
                if overlay is MKCircle{
                    let circleRenderer = MKCircleRenderer(overlay: overlay)
                    circleRenderer.fillColor = .blue
                    circleRenderer.alpha = 0.1

                    return circleRenderer
                    
                }
              
                    

                return nil
                    
            
    }
    
    }


    extension mapViewController: CLLocationManagerDelegate {
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapa.setRegion(region, animated: true)
            
        }
        
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            checkLocationAuthorization()
        }
      
        
        
        
    



}


