//
//  Paciente.swift
//  proyectoFinal
//
//  Created by Julio Alexis Rubio Gonzalez on 22/04/20.
//  Copyright © 2020 Jose Roberto. All rights reserved.
//

import UIKit
import Firebase

class Paciente: NSObject {
    var id : String
    var Nombre : String
    var Peso : Float
    var Altura : Float
    var Edad : Int
    var circAb : Float
    var Mediciones : [Medicion] = []
    var telefono : Int
    var correo : String
    var password:String
    var doctor : Doctor
    //var Medicinas = [String]()
    
    init(id:String,Nombre:String,Peso:Float,Altura:Float,Edad:Int,circAb:Float,telefono:Int,correo:String,password:String,doctor:Doctor){
        self.id = id
        self.Nombre = Nombre
        self.Peso = Peso
        self.Altura = Altura
        self.Edad = Edad
        self.circAb = circAb
        self.telefono = telefono
        self.correo = correo
        self.password = password
        self.doctor = doctor
        /*for Medicinas in Medicinas{
            self.Medicinas.append(Medicinas)
        }*/
    }
    
    func cambiarDoctor(docX:Doctor){
        self.doctor = docX
    }
    
    func agregarMedicion(sis:[Int],dia:[Int],fc:[Int],siguioMedicamentos:Bool){
        let medicion = Medicion(sis:sis,dia:dia,fc:fc,siguioMedicamentos: true)
        medicion.mandarMedicion()
        Mediciones.append(medicion)
    }
    
    func agregarUsuario(){
        var ref: DocumentReference? = nil
        let db = Firestore.firestore()
        ref = db.collection("users").addDocument(data:[
            "id":ref?.documentID,
            "nombre":Nombre,
            "peso":Peso,
            "altura":Altura,
            "edad":Edad,
            "circAb":circAb,
            "telefono" : telefono,
            "correo" : correo,
            "password":password
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                self.id = ref!.documentID
                let defaults = UserDefaults.standard
                defaults.set(self.id,forKey: defaultsKeys.keyOne)
                print("Document successfully written!")
                self.agregarId()
            }
        }
        
        
        
    }
    
    func agregarId(){
        var idX : String

        let defaults = UserDefaults.standard
        if let stringOne = defaults.string(forKey: defaultsKeys.keyOne) {
            print(stringOne) // Some String Value
            idX = stringOne
            let db = Firestore.firestore()
            db.collection("users").document(idX).setData([
                "id":idX
            ],merge: true) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    self.id = idX
                    print(self.id)
                }
            }
        }
    }
    
    func actualizarPaciente(Nombre:String,Peso:Float,Altura:Float,Edad:Int,circAb:Float,telefono:Int,correo:String){
        self.Nombre = Nombre
        self.Peso = Peso
        self.Altura = Altura
        self.Edad = Edad
        self.circAb = circAb
        self.telefono = telefono
        self.correo = correo
    }
    
    func agregarMedicionesDummy(){
        var idX:String
        let defaults = UserDefaults.standard
        if let stringOne = defaults.string(forKey: defaultsKeys.keyOne) {
            print(stringOne) // Some String Value
            idX = stringOne
            let db = Firestore.firestore()
            db.collection("users").document(idX).collection("Mediciones").addDocument(data: [
                "sis" : [],
                "dia" : [],
                "fc" : [],
                "timestamp" : Timestamp.init(),
                "esValida" : false,
                "siguioMedicamentos" : true
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
        
    }
    
}
