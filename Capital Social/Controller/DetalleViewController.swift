//
//  DetalleViewController.swift
//  Capital Social
//
//  Created by Jose Vargas on 05/04/20.
//  Copyright © 2020 joscompany. All rights reserved.
//

import UIKit

class DetalleViewController: UIViewController {
    
    var promocionName: String?
    @IBOutlet weak var imageDetalle: UIImageView!
    @IBOutlet weak var titlePromoDetalle: UILabel!
    @IBOutlet weak var detalleDescripcion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageName = promocionName {
            self.imageDetalle.image = UIImage(named: imageName)
        } else {
            self.imageDetalle.image = UIImage(named: "placeholder")
        }
        self.titlePromoDetalle.text = promocionName!
        self.detalleDescripcion.text = lorem
    }
    
    @IBAction func shareBtn(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: [promocionName!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
}
