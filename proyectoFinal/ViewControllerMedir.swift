//
//  ViewControllerMedir.swift
//  proyectoFinal
//
//  Created by Jose Roberto on 23/04/20.
//  Copyright © 2020 Jose Roberto. All rights reserved.
//

import UIKit

protocol ContainerToMaster {
    func ingresarDatos(uno:Int,dos:Int,tres:Int)
}

class ViewControllerMedir: UIViewController {
    
    
    @IBOutlet weak var tfSys: UITextField!
    @IBOutlet weak var tfAst: UITextField!
    @IBOutlet weak var tfFreqCard: UITextField!
    
    var containerToMaster:ContainerToMaster?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    func isInt(string: String) -> Bool {
        return Int(string) != nil
    }

    @IBAction func btSiguiente(_ sender: Any) {
        if tfSys.text! != "", tfAst.text! != "",tfFreqCard.text! != ""{
            if isInt(string: tfSys.text!) && isInt(string: tfAst.text!) && isInt(string: tfFreqCard.text!){
                let uno = Int(tfSys.text!)!
                let dos = Int(tfAst.text!)!
                let tres = Int(tfFreqCard.text!)!
                tfSys.text = ""
                tfAst.text = ""
                tfFreqCard.text = ""
                containerToMaster?.ingresarDatos(uno: uno, dos: dos, tres: tres)
            }else{
                let alerta = UIAlertController(title:"Error",message: "Los valores tienes que ser numeros naturales",preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(alerta,animated: true,completion: nil)
            }
        }
        else{
            let alerta = UIAlertController(title:"Error",message: "Los campos no pueden estar vacios",preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alerta,animated: true,completion: nil)
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
