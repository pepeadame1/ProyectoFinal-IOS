//
//  HistorialViewController.swift
//  proyectoFinal
//
//  Created by Julio Rubio on 09/05/20.
//  Copyright © 2020 Jose Roberto. All rights reserved.
//

import UIKit
import Firebase

class customCell: UITableViewCell{
    
    @IBOutlet weak var lblSist1: UILabel!
    @IBOutlet weak var lblSist2: UILabel!
    @IBOutlet weak var lblSist3: UILabel!
    @IBOutlet weak var lblDist1: UILabel!
    @IBOutlet weak var lblDist2: UILabel!
    @IBOutlet weak var lblDist3: UILabel!
    @IBOutlet weak var lblFq1: UILabel!
    @IBOutlet weak var lblFq2: UILabel!
    @IBOutlet weak var lblFq3: UILabel!
}

class HistorialViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var mainView: TabBarViewController!
    let defaults = UserDefaults.standard
    var toma = [Int]()
    var tomas = [[Int]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView = (tabBarController as! TabBarViewController)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tomas = []
        toma = []
        mainView = (tabBarController as! TabBarViewController)
        let idX = defaults.string(forKey: defaultsKeys.keyOne)!
        let db = Firestore.firestore()
        let user = db.collection("users").document(idX)
        user.getDocument{(document,error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
        user.collection("Mediciones").getDocuments(){(query, err) in
            if let err = err{
                print("Error")
            }else{
                for document in query!.documents{
                    let sis = document.get("sis") as! NSArray
                    let dia = document.get("dia") as! NSArray
                    let fc = document.get("fc") as! NSArray
                    for i in 0..<sis.count{
                        self.toma.append(sis[i] as! Int)
                        self.toma.append(dia[i] as! Int)
                        self.toma.append(fc[i] as! Int)
                    }
                    print("TOMA")
                    self.tomas.append(self.toma)
                    print(self.toma)
                    self.tableView.reloadData()
                    self.toma = []
                }
            }
        }
        
    }
}

extension HistorialViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return tomas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! customCell
        cell.lblSist1.text = String(tomas[indexPath.row][0])
        cell.lblDist1.text = String(tomas[indexPath.row][1])
        cell.lblFq1.text = String(tomas[indexPath.row][2])
        cell.lblSist2.text = String(tomas[indexPath.row][3])
        cell.lblDist2.text = String(tomas[indexPath.row][4])
        cell.lblFq2.text = String(tomas[indexPath.row][5])
        cell.lblSist3.text = String(tomas[indexPath.row][6])
        cell.lblDist3.text = String(tomas[indexPath.row][7])
        cell.lblFq3.text = String(tomas[indexPath.row][8])
        return cell
    }
    
}
