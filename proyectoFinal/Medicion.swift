//
//  Medicion.swift
//  proyectoFinal
//
//  Created by Jose Roberto on 23/04/20.
//  Copyright © 2020 Jose Roberto. All rights reserved.
//

import UIKit

class Medicion: NSObject {

    var sis : [Int]
    var dia : [Int]
    var fc : [Int]
    
    init(sis:[Int],dia:[Int],fc:[Int]){
        self.sis = sis
        self.dia = dia
        self.fc = fc
    }
}
