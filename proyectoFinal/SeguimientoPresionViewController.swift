//
//  SeguimientoPresionViewController.swift
//  proyectoFinal
//
//  Created by Julio Rubio on 27/05/20.
//  Copyright © 2020 Jose Roberto. All rights reserved.
//

import UIKit
import Firebase

struct defaultsKeys {
    static let keyOne = "firstStringKey"
    static let keyTwo = "secondStringKey"
}

class SeguimientoPresionViewController: UIViewController {
    @IBOutlet weak var btnIngresar: UIButton!
    @IBOutlet weak var btnCrearCuenta: UIButton!
    var loggedIn = false
    
    var pacienteUsuario = [Paciente]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("main")
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
                    let contra = document["password"]! as! String
                    let paciente = Paciente(id: id, Nombre: Nombre, Peso: Peso, Altura: Altura, Edad: Edad, circAb: circAb, telefono: telefono, correo: correo,password: contra, doctor: dummyDoctor)
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
        if segue.identifier == "loginSegue"{
            let bar = segue.destination as! TabBarViewController
            bar.paciente = pacienteUsuario[0]
        }
    }
}
