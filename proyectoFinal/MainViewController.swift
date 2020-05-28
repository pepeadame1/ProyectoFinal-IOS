//
//  MainViewController.swift
//  proyectoFinal
//
//  Created by Julio Rubio on 22/04/20.
//  Copyright © 2020 Jose Roberto. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var imgLoad1: UIImageView!
    @IBOutlet weak var imgLoad2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainView = tabBarController as! TabBarViewController
        
        self.definesPresentationContext = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        rotate1(imageView: imgLoad1, aCircleTime: 6)
        rotate2(imageView: imgLoad2, aCircleTime: 6)
    }
    
    //https://github.com/vin20777/Infinite-Rotate-Animation
    func rotate1(imageView: UIImageView, aCircleTime: Double) { //CABasicAnimation
            
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = -Double.pi * 2 //Minus can be Direction
            rotationAnimation.duration = aCircleTime
            rotationAnimation.repeatCount = .infinity
            imageView.layer.add(rotationAnimation, forKey: nil)
    }
    
    
    func rotate2(imageView: UIImageView, aCircleTime: Double) { //CABasicAnimation
            
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Double.pi * 2 //Minus can be Direction
            rotationAnimation.duration = aCircleTime
            rotationAnimation.repeatCount = .infinity
            imageView.layer.add(rotationAnimation, forKey: nil)
    }
}
