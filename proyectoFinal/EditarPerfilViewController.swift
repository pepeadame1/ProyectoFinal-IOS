//
//  EditarPerfilViewController.swift
//  proyectoFinal
//
//  Created by Julio Rubio on 22/04/20.
//  Copyright © 2020 Jose Roberto. All rights reserved.
//

import UIKit

class EditarPerfilViewController: UIViewController {
    
    @IBOutlet weak var tfPeso: UITextField!
    @IBOutlet weak var tfAltura: UITextField!
    @IBOutlet weak var tfEdad: UITextField!
    @IBOutlet weak var tfCirc: UITextField!
    
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainView = tabBarController as! TabBarViewController
        
        tfPeso.text = String(describing: mainView.paciente.Peso)
        tfAltura.text = String(describing: mainView.paciente.Altura)
        tfEdad.text = String(describing: mainView.paciente.Edad)
        tfCirc.text = String(describing: mainView.paciente.circAb)
        
        self.definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let mainView = tabBarController as! TabBarViewController
        tfPeso.text = String(describing: mainView.paciente.Peso)
        tfAltura.text = String(describing: mainView.paciente.Altura)
        tfEdad.text = String(describing: mainView.paciente.Edad)
        tfCirc.text = String(describing: mainView.paciente.circAb)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let mainView = tabBarController as! TabBarViewController
        if flag{
            flag = false
            mainView.paciente.Peso = Float(tfPeso.text!)!
            mainView.paciente.Altura = Float(tfAltura.text!)!
            mainView.paciente.Edad = Int(tfEdad.text!)!
            mainView.paciente.circAb = Float(tfCirc.text!)!
        }
        
    }
    
    @IBAction func GuardarNewInfo(_ sender: Any) {
        if let edad = Int(tfEdad.text!), let peso = Float(tfPeso.text!), let altura = Float(tfAltura.text!), let circAb = Float(tfCirc.text!){
            flag = true
            self.tabBarController?.selectedIndex = 0
        }
        else{
            print("Valor no valido")
        }
    }
    
}
