//
//  ViewController.swift
//  proyectoFinal
//
//  Created by Jose Roberto on 14/04/20.
//  Copyright © 2020 Jose Roberto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var stateMachine = 0
    var skip = false
    var temp1 = 300
    var temp2 = 180
    
    @IBOutlet weak var imgLoad1: UIImageView!
    @IBOutlet weak var imgLoad2: UIImageView!
    @IBOutlet weak var lbCounter: UILabel!
    @IBOutlet weak var lbCounterNumbers: UILabel!
    
    @IBOutlet weak var viewCounter: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rotate1(imageView: imgLoad1, aCircleTime: 6)
        rotate2(imageView: imgLoad2, aCircleTime: 6)
        // Do any additional setup after loading the view.
        
    }


    func fun1(){
        lbCounter.text = "porfavor mantengase quieto por 5 minutos"
        DispatchQueue.main.asyncAfter(deadline: .now() + 300) {
            self.lbCounter.text = "ahora tome las mediciones"
            self.stateMachine += 1
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if(self.temp1 > 0){
                let minutes = String(self.temp1 / 60)
                let seconds = String(self.temp1 % 60)
                self.lbCounterNumbers.text = minutes + ":" + seconds
                self.temp1 -= 1
            }else{
              timer.invalidate()
            }
        }
    }
    
    func fun2(){
        lbCounter.text = "porfavor mantengase quieto por 3 minutos"
        DispatchQueue.main.asyncAfter(deadline: .now() + 180) {
            self.lbCounter.text = "ahora tome las mediciones"
            self.stateMachine += 1
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if(self.temp2 > 0){
                let minutes = String(self.temp2 / 60)
                let seconds = String(self.temp2 % 60)
                self.lbCounterNumbers.text = minutes + ":" + seconds
                self.temp2 -= 1
            }else{
              timer.invalidate()
            }
        }
    }
    
    
    
    @IBAction func startFunctions(_ sender: Any) {
        switch stateMachine {
        case 0:
            fun1()
        case 1:
            fun2()
        default:
            lbCounter.text = "ERROR"
        }
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

