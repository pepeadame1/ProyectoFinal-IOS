//
//  AgregarMedicinasViewController.swift
//  proyectoFinal
//
//  Created by Julio Rubio on 22/04/20.
//  Copyright © 2020 Jose Roberto. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell{
    @IBOutlet weak var medicina: UILabel!
}

class AgregarMedicinasViewController: UIViewController,UITextFieldDelegate{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tfAgregarMedicina: UITextField!
    
    var medicinas : [String] = []
    var pacientes = [Paciente]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func agregarMedicina(_ sender: Any) {
        
        medicinas.append(tfAgregarMedicina.text!)
        
        let indexPath = IndexPath(row: medicinas.count - 1, section:0)
        
        tableView.beginUpdates()
        
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        tableView.endUpdates()
        
        tfAgregarMedicina.text = ""
        
        view.endEditing(true)
        
    }
}

extension AgregarMedicinasViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return medicinas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        
        cell.medicina.text = medicinas[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            medicinas.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    
}
