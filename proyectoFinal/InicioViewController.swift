//
//  InicioViewController.swift
//  proyectoFinal
//
//  Created by Julio Rubio on 22/04/20.
//  Copyright © 2020 Jose Roberto. All rights reserved.
//

import UIKit
import Firebase

class InicioViewController: UIViewController{
    
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfPeso: UITextField!
    @IBOutlet weak var tfAltura: UITextField!
    @IBOutlet weak var tfEdad: UITextField!
    @IBOutlet weak var tfCircAb: UITextField!
    var loggedIn = false
    
    var UserEmail:String!
    var password:String!
    
    var pacienteUsuario = [Paciente]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        if let stringOne = defaults.string(forKey: defaultsKeys.keyOne) {
            let db = Firestore.firestore()
            let userRef = db.collection("users").document(stringOne)
            userRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    let dummyDoctor = Doctor(nombre:"test",telefono: 0,email:"no",id:"test")
                    
                    let id = document["id"]! as! String
                    let Nombre = document["nombre"]! as! String
                    let Peso = document["peso"]! as! Float
                    let Altura = document["altura"]! as! Float
                    let Edad = document["edad"]! as! Int
                    let circAb = document["circAb"]! as! Float
                    //falta sacar mediciones
                    let telefono = document["telefono"]! as! Int
                    let correo = document["correo"]! as! String
                    let contra = document["password"]! as! String
                    let paciente = Paciente(id: id, Nombre: Nombre, Peso: Peso, Altura: Altura, Edad: Edad, circAb: circAb, telefono: telefono, correo: correo,password: contra, doctor: dummyDoctor)
                    self.pacienteUsuario.append(paciente)
                    self.performSegue(withIdentifier: "loginSegue", sender: self)
                }
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let bar = segue.destination as! TabBarViewController
        bar.paciente = pacienteUsuario[0]
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        let dummyDoctor = Doctor(nombre:"test",telefono: 0,email:"no",id:"test")
        
        if tfNombre.text != "",let edad = Int(tfEdad.text!), let peso = Float(tfPeso.text!), let altura = Float(tfAltura.text!), let circAb = Float(tfCircAb.text!){
            
            let id = "testPaciente"
            
            let paciente = Paciente(id:id,Nombre: tfNombre.text!, Peso: peso, Altura: altura, Edad: edad, circAb: circAb,telefono: 666,correo:UserEmail,password: password,doctor: dummyDoctor)
            paciente.agregarUsuario()
            pacienteUsuario.append(paciente)
                return true
            }
        let alerta = UIAlertController(title:"Error",message: "No pueden haber campos vacíos",preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alerta,animated: true,completion: nil)
        return false
    }
    
    @IBAction func regresar(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
