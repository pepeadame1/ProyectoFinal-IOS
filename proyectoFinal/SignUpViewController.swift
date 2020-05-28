//
//  SignUpViewController.swift
//  proyectoFinal
//
//  Created by Julio Rubio on 26/05/20.
//  Copyright © 2020 Jose Roberto. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfContraseña: UITextField!
    @IBOutlet weak var tfConfirmacionContraseña: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hi")
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let val = segue.destination as!InicioViewController
        val.UserEmail = tfEmail.text!
        val.password = tfContraseña.text!
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if tfContraseña.text != "",tfConfirmacionContraseña.text != "", tfEmail.text != "", tfConfirmacionContraseña.text == tfContraseña.text{
            return true
        }
        return false
    }
    
    @IBAction func regresar(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
