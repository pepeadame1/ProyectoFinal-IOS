//
//  Paciente.swift
//  proyectoFinal
//
//  Created by Julio Alexis Rubio Gonzalez on 22/04/20.
//  Copyright © 2020 Jose Roberto. All rights reserved.
//

import UIKit

class Paciente: NSObject {
    var Nombre : String
    var Peso : Float
    var Altura : Float
    var Edad : Int
    var circAb : Float
    var Mediciones : [Medicion] = []
    
    //var Medicinas = [String]()
    
    init(Nombre:String,Peso:Float,Altura:Float,Edad:Int,circAb:Float){
        self.Nombre = Nombre
        self.Peso = Peso
        self.Altura = Altura
        self.Edad = Edad
        self.circAb = circAb
        /*for Medicinas in Medicinas{
            self.Medicinas.append(Medicinas)
        }*/
    }
    
    func agregarMedicion(sis:[Int],dia:[Int],fc:[Int]){
        let medicion = Medicion(sis:sis,dia:dia,fc:fc)
        Mediciones.append(medicion)
    }
}
