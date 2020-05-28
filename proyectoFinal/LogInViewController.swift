//
//  LogInViewController.swift
//  proyectoFinal
//
//  Created by Julio Rubio on 26/05/20.
//  Copyright © 2020 Jose Roberto. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPass: UITextField!
    
    var id:String!
    var Nombre:String!
    var Peso:Float!
    var Altura:Float!
    var Edad:Int!
    var circAb:Float!
    var telefono:Int!
    var correo:String!
    var contraseña:String!
    var flag = false
    
    var pacienteUsuario = [Paciente]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let defaults = UserDefaults.standard
        defaults.set(self.id,forKey: defaultsKeys.keyOne)
        let bar = segue.destination as! TabBarViewController
        bar.paciente = pacienteUsuario[0]
    }
    
    
    @IBAction func validateUser(_ sender: Any) {
        if tfEmail.text != "", tfPass.text != ""{
            let db = Firestore.firestore()
            _ = db.collection("users").whereField("correo", isEqualTo: self.tfEmail.text!).getDocuments{(querySnapshot,err) in
                if err != nil{
                }
                else{
                    for document in querySnapshot!.documents{
                        if self.tfPass.text == (document.get("password") as! String){
                            self.id = (document.get("id") as! String)
                            self.Nombre = (document["nombre"]! as! String)
                            self.Peso = (document["peso"]! as! Float)
                            self.Altura = (document["altura"]! as! Float)
                            self.Edad = (document["edad"]! as! Int)
                            self.circAb = (document["circAb"]! as! Float)
                            //falta sacar mediciones
                            self.telefono = (document["telefono"]! as! Int)
                            self.correo = (document["correo"]! as! String)
                            self.contraseña = (document["password"]! as! String)
                            let dummyDoctor = Doctor(nombre:"test",telefono: 0,email:"no",id:"test")
                            let paciente = Paciente(id: self.id, Nombre: self.Nombre, Peso: self.Peso, Altura: self.Altura, Edad: self.Edad, circAb: self.circAb, telefono: self.telefono, correo: self.correo,password: self.contraseña, doctor: dummyDoctor)
                            self.pacienteUsuario.append(paciente)
                            self.performSegue(withIdentifier: "loginSegue", sender: self)
                        }
                        else{
                            let alerta = UIAlertController(title:"Error",message: "No pueden haber campos vacíos",preferredStyle: .alert)
                            alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                            self.present(alerta,animated: true,completion: nil)
                        }
                    }
                }
            }
            
        }
    }
    
    @IBAction func regresar(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
