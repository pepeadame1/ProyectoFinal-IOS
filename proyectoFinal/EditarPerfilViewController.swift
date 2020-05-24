//
//  EditarPerfilViewController.swift
//  proyectoFinal
//
//  Created by Julio Rubio on 22/04/20.
//  Copyright © 2020 Jose Roberto. All rights reserved.
//

import UIKit
import Firebase

class EditarPerfilViewController: UIViewController {
    
    @IBOutlet weak var tfPeso: UITextField!
    @IBOutlet weak var tfAltura: UITextField!
    @IBOutlet weak var tfEdad: UITextField!
    @IBOutlet weak var tfCirc: UITextField!
    
    var flag = false
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let mainView = tabBarController as! TabBarViewController
        let idX = defaults.string(forKey: defaultsKeys.keyOne)!
        let db = Firestore.firestore()
        let user = db.collection("users").document(idX)
        
        user.getDocument{(document,error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                self.tfEdad.text = String(document.get("edad") as! Int)
                self.tfPeso.text = String(document.get("peso") as! Float)
                self.tfAltura.text = String(document.get("altura") as! Float)
                self.tfCirc.text = String(document.get("circAb") as! Float)
            } else {
                print("Document does not exist")
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let mainView = tabBarController as! TabBarViewController
        if flag{
            flag = false
            let idX = defaults.string(forKey: defaultsKeys.keyOne)!
            let db = Firestore.firestore()
            let user = db.collection("users")
            
            user.whereField("id", isEqualTo: idX).getDocuments(){(query, err) in
                if let err = err {
                    //error
                }else {
                    let doc = query!.documents.first
                    doc?.reference.updateData([
                        "edad": Int(self.tfEdad.text!),
                        "circAb": Float(self.tfCirc.text!),
                        "altura": Float(self.tfAltura.text!),
                        "peso": Float(self.tfPeso.text!)
                    ])
                }
            }
        }
        
    }
    
    @IBAction func GuardarNewInfo(_ sender: Any) {
        if let edad = Int(tfEdad.text!), let peso = Float(tfPeso.text!), let altura = Float(tfAltura.text!), let circAb = Float(tfCirc.text!){
            flag = true
            self.tabBarController?.selectedIndex = 0
        }
        else{
            print("Algun Valor no es valido")
        }
    }
    
}
