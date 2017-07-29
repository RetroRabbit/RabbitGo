//
//  ScanQR.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/17.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import Firebase
import AVFoundation
import UIKit
import Material
import Icomoon

// Source: https://www.hackingwithswift.com/example-code/media/how-to-scan-a-qr-code

class ScanQRController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    static let instance = ScanQRController()
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        tabBarItem.setTitleTextAttributes(Style.avenirh_xsmall_white_center, for: .normal)
        tabBarItem.title = "ScanQR"
        tabBarItem.image = UIImage.iconWithName(Icomoon.Icon.Camera, textColor: Material.Color.white, fontSize: 20).withRenderingMode(.alwaysOriginal)
        tabBarItem.selectedImage = UIImage.iconWithName(Icomoon.Icon.Camera, textColor: Style.color.green, fontSize: 20).withRenderingMode(.alwaysOriginal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        let videoCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed();
            return;
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
        previewLayer.frame = view.layer.bounds;
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        view.layer.addSublayer(previewLayer);
        
        captureSession.startRunning();
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning();
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning();
        }
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            let readableObject = metadataObject as! AVMetadataMachineReadableCodeObject;
            
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: readableObject.stringValue);
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    /* Once QR code is detected */
    func found(code: String) {
//        refQuestion(questionId: code).observeSingleEvent(of: .value, with: { (snapshot) in
//            
//        })
        
        let alert: UIAlertController
        let (index, question) = questionScanned(qrCode: code)
        
        if index == -1 {
            alert = UIAlertController(title: "Invalid QR code scanned", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler: { _ in
                if (self.captureSession?.isRunning == false) {
                    self.captureSession.startRunning();
                }
            }))
        } else if question?.state ?? 0 > 0 {
            alert = UIAlertController(title: "You've already scanned\nthis QR code!", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler: { _ in
                if (self.captureSession?.isRunning == false) {
                    self.captureSession.startRunning();
                }
            }))
        } else {
            alert = UIAlertController(title: "You scanned QR #\(index)", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler: { _ in
                if (self.captureSession?.isRunning == false) {
                    self.captureSession.startRunning();
                }
            }))
            alert.addAction(UIAlertAction(title: "View", style: .default, handler: { _ in
                // TODO: Open scanned QR question
                question?.state = 1
                firebaseQuestions[index] = question
                
                refCurrentUserQuestions().observeSingleEvent(of: .value, with: { [weak self] (dataSnapShot) in
                    guard let this = self else { return }
                    let answeredQuestion = dataSnapShot.childSnapshot(forPath: question?.qrCode ?? "")
                    answeredQuestion.childSnapshot(forPath: "state").ref.setValue(1)
                })
                
                self.navigationController?.popViewController(animated: true)
                self.tabBarController?.selectedIndex = 1
            }))
        }
    
        
        present(alert, animated: true, completion: nil)
    }
    
    func questionScanned(qrCode: String) -> (Int, Question?) {
        for (index, question) in firebaseQuestions.enumerated() {
            if question?.qrCode as? String == qrCode {
                return (index, question)
            }
        }
        
        return (-1, nil)
    }
}
