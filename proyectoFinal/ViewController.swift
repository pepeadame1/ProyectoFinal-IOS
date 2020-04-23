//
//  ViewController.swift
//  proyectoFinal
//
//  Created by Jose Roberto on 14/04/20.
//  Copyright © 2020 Jose Roberto. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ContainerToMaster {
    
    var work : DispatchWorkItem?
    
    
    @IBOutlet weak var containerView: UIView!
    var containerViewController : ViewControllerMedir?
    
    
    var stateMachine = 0
    var skip = false
    var temp1 = 30
    var temp2 = 12
    
    var med1:[Int] = []
    var med2:[Int] = []
    var med3:[Int] = []
    
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
        animateOut()
        
    }
    
    /*
     MAQUINA DE ESTADOS
     0-No ha empezado a tomar medicion
     1-Esta esperando el primer timer
     2-Esta metiendo los primeros datos
     3-Acabo la primer medicion
     4-Esta esperando el segundo timer
     5-Esta metiendo los segundos datos
     6-Acabo la segunda medicion
     7-Esta esperando el tercer timer
     8-Esta metiendo los terceros datos
     9-Acabo la tercer medicion.
     
     */

    
    func animateIn(){
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [], animations: {

           let screenSize = UIScreen.main.bounds.size

            let x = screenSize.width/2 - self.containerView.frame.size.width/2
            let y = screenSize.height/2 - self.containerView.frame.size.height/2

           self.containerView.frame = CGRect(x: x, y: y, width: self.containerView.frame.size.width, height: self.containerView.frame.size.height)

        })
    }
    
    func animateOut(){
        let trailingSpace: CGFloat = 10
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [], animations: {

           let screenSize = UIScreen.main.bounds.size

           let x = screenSize.width - self.containerView.frame.size.width - trailingSpace

           self.containerView.frame = CGRect(x: x, y: -1000, width: self.containerView.frame.size.width, height: self.containerView.frame.size.height)

        })
    }
    
    func timer(timeX: Int){
        var timeZ = timeX
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if(timeZ > 0 && !self.skip){
                let minutes = String(timeZ / 60)
                let seconds = String(timeZ % 60)
                self.lbCounterNumbers.text = minutes + ":" + seconds
                timeZ -= 1
            }else{
                timeZ = 0
                self.skip = false
                self.lbCounterNumbers.text = "0:00"
                timer.invalidate()
            }
        }
    }

    func terminaReloj(){
        lbCounter.text = "ahora tome las mediciones"
        stateMachine += 1
        animateIn()
    }
    
    func fun1(){
        self.stateMachine += 1
        timer(timeX: self.temp1)
        lbCounter.text = "porfavor mantengase quieto por 5 minutos"
        
        work = DispatchWorkItem(block: {
            self.terminaReloj()
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(self.temp1),execute: work!)
    }
    
    func fun2(){
        self.stateMachine += 1
        timer(timeX: self.temp2)
        lbCounter.text = "porfavor mantengase quieto por 3 minutos"
        work = DispatchWorkItem(block: {
            self.terminaReloj()
        })
               
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(self.temp2),execute: work!)
    }
    
    
    
    @IBAction func startFunctions(_ sender: Any) {
        switch stateMachine {
        case 0:
            fun1()
        case 3:
            fun2()
        case 6:
            fun2()
        case 9:
            let medicion = Medicion(sis: med1,dia: med2,fc: med3)
            //TODO: cerrer
            print("cerrar vista")
        default:
            //lbCounter.text = "ERROR"
            print("no")
        }
    }
    
    
    @IBAction func handleGesture(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began{
            //1,4,7
            if stateMachine == 1 || stateMachine == 4 || stateMachine == 7{
                work!.cancel()
                lbCounter.text = "ahora tome las mediciones"
                stateMachine += 1
                skip = true
                animateIn()
            }
            
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
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "medirSegue" {
            
            containerViewController = segue.destination as? ViewControllerMedir
            containerViewController!.containerToMaster = self
        }
    }
    
    
    func ingresarDatos(uno:Int,dos:Int,tres:Int){
        print(stateMachine)
        switch stateMachine {
        case 2:
            med1.append(uno)
            med1.append(dos)
            med1.append(tres)
        case 5:
            med2.append(uno)
            med2.append(dos)
            med2.append(tres)
        case 8:
            med3.append(uno)
            med3.append(dos)
            med3.append(tres)
        default:
            lbCounter.text = "ERROR"
        }
        self.stateMachine += 1
        lbCounterNumbers.text = "Siguiente"
        animateOut()
        print(med1)
        print(med2)
        print(med3)
    }
    
}

