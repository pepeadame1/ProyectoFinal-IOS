//
//  InicioViewController.swift
//  proyectoFinal
//
//  Created by Julio Rubio on 22/04/20.
//  Copyright © 2020 Jose Roberto. All rights reserved.
//

import UIKit

struct defaultsKeys {
    static let keyOne = "firstStringKey"
    static let keyTwo = "secondStringKey"
}

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
        let bar = segue.destination as! TabBarViewController
        bar.paciente = pacienteUsuario[0]
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        
        if let nombre = tfNombre.text,let edad = Int(tfEdad.text!), let peso = Float(tfPeso.text!), let altura = Float(tfAltura.text!), let circAb = Float(tfCircAb.text!){
            
            let id = "test"
            
            let paciente = Paciente(id:id,Nombre: nombre, Peso: peso, Altura: altura, Edad: edad, circAb: circAb,telefono: 666,correo:"huajuco4@gmail.com")
            paciente.agregarUsuario()
            
            
            
            pacienteUsuario.append(paciente)
                return true
            }
        return false
    }
    
}
