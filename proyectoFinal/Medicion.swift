//
//  Medicion.swift
//  proyectoFinal
//
//  Created by Jose Roberto on 23/04/20.
//  Copyright © 2020 Jose Roberto. All rights reserved.
//

import UIKit
import Firebase

class Medicion: NSObject {

    var sis : [Int]
    var dia : [Int]
    var fc : [Int]
    var esValida : Bool
    var timestampX : Timestamp
    var siguioMedicamentos : Bool
    
    init(sis:[Int],dia:[Int],fc:[Int],siguioMedicamentos:Bool){
        self.sis = sis
        self.dia = dia
        self.fc = fc
        self.esValida = true
        self.siguioMedicamentos = siguioMedicamentos
        self.timestampX = Timestamp.init()
    }
    
    init(sis:[Int],dia:[Int],fc:[Int],esValida:Bool,timestamp:Timestamp,siguioMedicamentos:Bool){
        self.sis = sis
        self.dia = dia
        self.fc = fc
        self.timestampX = timestamp
        self.siguioMedicamentos = siguioMedicamentos
        self.esValida = esValida
    }
    
    func mandarMedicion(){
        
        var idX : String
        
        let defaults = UserDefaults.standard
        if let stringOne = defaults.string(forKey: defaultsKeys.keyOne) {
            print(stringOne) // Some String Value
            idX = stringOne
            let db = Firestore.firestore()
           
            db.collection("users").document(idX).collection("Mediciones").addDocument(data: [
                "sis" : sis,
                "dia" : dia,
                "fc" : fc,
                "timestamp" : timestampX,
                "esValida" : esValida,
                "siguioMedicamentos" : siguioMedicamentos
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
