//
//  PromocionesViewController.swift
//  Capital Social
//
//  Created by Jose Vargas on 05/04/20.
//  Copyright © 2020 joscompany. All rights reserved.
//

import UIKit

class PromocionesViewController: UIViewController {

    @IBOutlet weak var promocionesCollectionV: UICollectionView!
    let promociones = ["PromoBenavides",
    "PromoBurguerKing",
    "PromoChilis",
    "PromoCinepolis",
    "PromoIdea",
    "PromoItaliannis",
    "PromoTizoncito",
    "PromoWingstop",
    "PromoZonaFitness",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.promocionesCollectionV.delegate = self
        self.promocionesCollectionV.dataSource = self
        
        setCollectionViewLayout()
    }
    
    func setCollectionViewLayout(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        promocionesCollectionV.setCollectionViewLayout(layout, animated: true)
    }
}

extension PromocionesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return promociones.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! CustomViewCell
        cell.imageCell.image = UIImage(named: promociones[indexPath.item])
        cell.labelCell.text = promociones[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetalleStoryBid") as? DetalleViewController
        vc?.promocionName = promociones[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)// value for spacing
        }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                let lay = collectionViewLayout as! UICollectionViewFlowLayout
                let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing

    return CGSize(width:widthPerItem, height:100)
    }
    
}
