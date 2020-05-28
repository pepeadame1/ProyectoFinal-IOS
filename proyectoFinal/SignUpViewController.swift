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
    var flag:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let val = segue.destination as!InicioViewController
        val.UserEmail = tfEmail.text!
        val.password = tfContraseña.text!
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if tfContraseña.text != "",tfConfirmacionContraseña.text != "", tfEmail.text != ""{
            if tfConfirmacionContraseña.text == tfContraseña.text{
                flag = isValidEmail(tfEmail.text!)
                if flag{
                    return true}
                else{
                    let alerta = UIAlertController(title:"Error",message: "El email no es valido",preferredStyle: .alert)
                    alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    present(alerta,animated: true,completion: nil)
                }
            }
            else{
                let alerta = UIAlertController(title:"Error",message: "Las contraseñas deben de coincidir",preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(alerta,animated: true,completion: nil)
            }
        }
        let alerta = UIAlertController(title:"Error",message: "No pueden haber campos vacíos",preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alerta,animated: true,completion: nil)
        return false
    }
    
    @IBAction func regresar(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
