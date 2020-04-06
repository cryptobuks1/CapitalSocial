//
//  ActivityIndicator.swift
//  Capital Social
//
//  Created by Jose Vargas on 06/04/20.
//  Copyright © 2020 joscompany. All rights reserved.
//

import Foundation
import UIKit

open class CustomActivityIndicator {
    
    // MARK: - Properties
    internal static var spinner = UIActivityIndicatorView()
    public static var backColor = UIColor.black.withAlphaComponent(0.5)
    public static var spinerColor = UIColor.white
    
    // MARK: - Initialize
    public static func start(backGroundColor: UIColor = backColor, spinerColor: UIColor = spinerColor) {
        if let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) {
            let frame = UIScreen.main.bounds
            spinner = UIActivityIndicatorView(frame: frame)
            if #available(iOS 13, *) {
                spinner.style = .large
            } else {
                spinner.style = .whiteLarge
            }
            spinner.backgroundColor = backGroundColor
            spinner.color = spinerColor
            window.addSubview(spinner)
            DispatchQueue.main.async {
                spinner.startAnimating()
            }
        }
    }
    
    public static func stop() {
        DispatchQueue.main.async {
            if spinner.isAnimating {
                spinner.stopAnimating()
                spinner.removeFromSuperview()
            }
        }
    }
}
