import UIKit
import AVKit
import Vision

public var name1 = String()
public var arrayMonumentsFinal = [String]()

class cameraViewController: UIViewController , AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var capSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    override var prefersStatusBarHidden: Bool{return true}
    
    
   
    @IBOutlet weak var bellowview: UIView!
    
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mapButton.layer.cornerRadius = 30 // Botón redondeado
        infoButton.layer.cornerRadius = 30
        
        capSession.sessionPreset = .photo
        
        guard let capDevice = AVCaptureDevice.default(for: AVMediaType.video)else{return}
        
        guard let input = try? AVCaptureDeviceInput(device: capDevice)else{return}
        
        capSession.addInput(input)
        capSession.startRunning()
        
        previewLayer = AVCaptureVideoPreviewLayer(session: capSession)
        view.layer.addSublayer(previewLayer!)
        previewLayer!.frame = view.frame
        
        let outputData = AVCaptureVideoDataOutput()
        
        outputData.setSampleBufferDelegate(self, queue: DispatchQueue(label: "Queue"))
        capSession.addOutput(outputData)
        
        
        
        
    }
    
    
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
            
            guard let buffer:CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else{
                return
            }
            
            guard let dataModel = try? VNCoreMLModel(for: rutf_1().model) else {
                return
            }
            let request = VNCoreMLRequest(model: dataModel){(res, error)
                in
                
                guard let result = res.results as?
                    [VNClassificationObservation] else {return}
                
                guard let observationData = result.first else {return}
                
                //print(observationData.identifier, observationData.confidence)
                
                name1 = observationData.identifier
                
                if !arrayMonumentsFinal.contains(name1) && observationData.confidence > 0.95{
                    
                    arrayMonumentsFinal.append(name1)
                    
                    
                    DispatchQueue.main.async {
                        

                        let storyboard = UIStoryboard(name: "Main", bundle: nil)

                        let redViewController = storyboard.instantiateViewController(withIdentifier: "listVC") as! listMonumentsViewController
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window?.rootViewController = redViewController
                        
                        
                    }

                    

                    
                    
                    
    //                self.capSession.stopRunning()
                }
                //print(arrayMonumentsFinal)
                
            }
            
            try? VNImageRequestHandler(cvPixelBuffer: buffer, options: [:]).perform([request])
            
            
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
    //        previewLayer?.removeFromSuperlayer()
    //        capSession.stopRunning()
            self.dismiss(animated: false, completion: nil)
        }
    
   
    
    @IBAction func infoButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let vc = storyboard.instantiateViewController(withIdentifier: "infoVC") as! infoViewController

        /*vc.modalPresentationStyle = .overFullScreen*/

        present(vc, animated: true)

    }
    

}
