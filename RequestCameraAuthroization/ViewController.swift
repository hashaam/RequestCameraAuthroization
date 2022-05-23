//
//  ViewController.swift
//  RequestCameraAuthroization
//
//  Created by Hashaam Siddiq on 8/5/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let authorizationStatus = getCameraAuthorization()
        switch authorizationStatus {
        case .notDetermined:
            print("Camera permission has not yet granted. We can request camera permission from the user")
            
            requestCameraAuthorization { granted in
                let grantedStatus = granted ? "granted" : "not granted"
                print("Camera permission was \(grantedStatus)")
            }
            
        case .restricted:
            print("User is not allowed to access media capture device.")
            
        case .denied:
            print("User has denied accessing camera. We need to request user to allow the camera permission from settings.")
            
        case .authorized:
            print("Camera permission was granted")
            
        @unknown default:
            print("Camera authorization status is unknown.")
            
        }
        
    }
    
    func getCameraAuthorization() -> AVAuthorizationStatus {
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        return authorizationStatus
    }
    
    func requestCameraAuthorization(completionHandler: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            completionHandler(granted)
        }
    }
    
}

