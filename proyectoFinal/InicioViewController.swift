//
//  InicioViewController.swift
//  proyectoFinal
//
//  Created by Julio Rubio on 22/04/20.
//  Copyright © 2020 Jose Roberto. All rights reserved.
//

import UIKit
import Firebase

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
    var loggedIn = false
    
    var pacienteUsuario = [Paciente]()

    override func viewDidLoad() {
        super.viewDidLoad()

        print("test")
        let defaults = UserDefaults.standard
        if let stringOne = defaults.string(forKey: defaultsKeys.keyOne) {
            print(stringOne)
            let db = Firestore.firestore()
            let userRef = db.collection("users").document(stringOne)
            userRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data: \(dataDescription)")
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
                    let paciente = Paciente(id: id, Nombre: Nombre, Peso: Peso, Altura: Altura, Edad: Edad, circAb: circAb, telefono: telefono, correo: correo, doctor: dummyDoctor)
                    self.pacienteUsuario.append(paciente)
                    self.performSegue(withIdentifier: "loginSegue", sender: self)
                } else {
                    print("Document does not exist")
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
        
        if loggedIn{
            
            return true
        }else{
            
        
        let dummyDoctor = Doctor(nombre:"test",telefono: 0,email:"no",id:"test")
        
        if let nombre = tfNombre.text,let edad = Int(tfEdad.text!), let peso = Float(tfPeso.text!), let altura = Float(tfAltura.text!), let circAb = Float(tfCircAb.text!){
            
            let id = "testPaciente"
            
            let paciente = Paciente(id:id,Nombre: nombre, Peso: peso, Altura: altura, Edad: edad, circAb: circAb,telefono: 666,correo:"huajuco4@gmail.com",doctor: dummyDoctor)
            paciente.agregarUsuario()
            
            
            
            pacienteUsuario.append(paciente)
                return true
            }
        }
        return false
    }
    
}
