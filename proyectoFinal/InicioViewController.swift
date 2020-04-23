//
//  InicioViewController.swift
//  proyectoFinal
//
//  Created by Julio Rubio on 22/04/20.
//  Copyright © 2020 Jose Roberto. All rights reserved.
//

import UIKit


class InicioViewController: UIViewController{
    
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfPeso: UITextField!
    @IBOutlet weak var tfAltura: UITextField!
    @IBOutlet weak var tfEdad: UITextField!
    @IBOutlet weak var tfCircAb: UITextField!
    
    
    var pacienteUsuario = [Paciente]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let bar = segue.destination as! UITabBarController
        let nav = bar.viewControllers![0] as! UIViewController
        let vc = nav as! MainViewController
        vc.paciente = pacienteUsuario[0]
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        
        if let nombre = tfNombre.text,let edad = Int(tfEdad.text!), let peso = Float(tfPeso.text!), let altura = Float(tfAltura.text!), let circAb = Float(tfCircAb.text!){
            let paciente = Paciente(Nombre: nombre, Peso: peso, Altura: altura, Edad: edad, circAb: circAb)
            pacienteUsuario.append(paciente)
                return true
            }
        return false
    }
    
}
