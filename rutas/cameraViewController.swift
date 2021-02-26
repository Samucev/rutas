import UIKit
import AVKit
import Vision



class cameraViewController: UIViewController , AVCaptureVideoDataOutputSampleBufferDelegate {
    
    override var prefersStatusBarHidden: Bool{return true}
    
    
   
    @IBOutlet weak var bellowview: UIView!
    
    var model = mapa1().model
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let captureseSesion = AVCaptureSession()
        guard let captureDevice = AVCaptureDevice.default(for: .video)else {return}
        guard let input = try? AVCaptureDeviceInput(device: captureDevice)else {return}
        captureseSesion.addInput(input)
        captureseSesion.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureseSesion)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        //camara creada
        
       
        view.addSubview(bellowview)
              bellowview.clipsToBounds = true
              bellowview.layer.cornerRadius = 15.0
              bellowview.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label:"videoQueue"))
        captureseSesion.addOutput(dataOutput)
        
        
        
        
        
    }
    
    
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)else {return}
        
        guard let model = try? VNCoreMLModel(for: model )else{return}
        let request = VNCoreMLRequest(model: model ){ (finishedReq,err)
         in
            guard let results = finishedReq.results as? [VNClassificationObservation] else {return}
            guard let firstObservation = results.first else {return}
            
            var name: String = firstObservation.identifier
            var acc: Int = Int(firstObservation.confidence * 100)
           
         
        }
        //https://www.youtube.com/watch?v=SkgHz8nw5V8&t=1031s
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
        
    }
    


}
