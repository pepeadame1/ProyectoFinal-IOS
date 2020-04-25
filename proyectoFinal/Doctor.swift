//
//  Doctor.swift
//  proyectoFinal
//
//  Created by Jose Roberto on 24/04/20.
//  Copyright © 2020 Jose Roberto. All rights reserved.
//

import UIKit
import Firebase

class Doctor: NSObject {
    
    var nombre : String
    var telefono : Int
    var email : String
    var id : String
    var pacientes : [Paciente] = []
    
    init(nombre : String,telefono : Int, email:String,id:String){
        self.nombre = nombre
        self.telefono = telefono
        self.email = email
        self.id = id
    }
    
    override init() {
        self.nombre = "ERROR"
        self.telefono = 0
        self.email = "ERROR"
        self.id = "ERROR"
    }
    
    func agregarPaciente(paciente:Paciente){
        //agregar a base de datos.
        
        pacientes.append(paciente)
        
    }
    
    func guardarDoctor(){
        var ref: DocumentReference? = nil
        let db = Firestore.firestore()
        ref = db.collection("doctors").addDocument(data: [
            "nombre" : nombre,
            "telefono" : telefono,
            "email" : email,
            "id" : "tempDoctor"
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                self.id = ref!.documentID
                let defaults = UserDefaults.standard
                defaults.set(self.id,forKey: defaultsKeys.keyTwo)
                self.agregarId()
                print("Document successfully written!")
            }
        }
    }
    
    func agregarId(){
        
        var idX : String

        let defaults = UserDefaults.standard
        if let stringOne = defaults.string(forKey: defaultsKeys.keyTwo) {
            idX = stringOne
            let db = Firestore.firestore()
            db.collection("doctors").document(idX).setData([
                "id":idX
            ],merge: true) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    self.id = idX
                    print(self.id)
                    self.agregarPacientesDummy()
                }
            }
        }
    }
    
    func agregarPacientesDummy(){
        var idX:String
        let defaults = UserDefaults.standard
        if let stringOne = defaults.string(forKey: defaultsKeys.keyTwo) {
            idX = stringOne
            let db = Firestore.firestore()
            db.collection("doctors").document(idX).collection("pacientes").addDocument(data: [
                "id" : "test"
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
    }
    
    func borrarPaciente(paciente:Paciente){
        if let index = pacientes.firstIndex(of: paciente){
            pacientes.remove(at: index)
        }
        //borrar de db
    }
    
}
