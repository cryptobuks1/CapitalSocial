//
//  QRreaderViewController.swift
//  Capital Social
//
//  Created by Jose Vargas on 06/04/20.
//  Copyright © 2020 joscompany. All rights reserved.
//

import UIKit
import AVFoundation
import QRCodeReader

class QRreaderViewController: UIViewController, QRCodeReaderViewControllerDelegate {
    // Good practice: create the reader lazily to avoid cpu overload during the
    // initialization and each time we need to scan a QRCode
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            
            // Configure the view controller (optional)
            $0.showTorchButton        = false
            $0.showSwitchCameraButton = false
            $0.showCancelButton       = false
            $0.showOverlayView        = true
            $0.rectOfInterest         = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        <#code#>
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        <#code#>
    }


}
