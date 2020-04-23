//
//  MainViewController.swift
//  proyectoFinal
//
//  Created by Julio Rubio on 22/04/20.
//  Copyright © 2020 Jose Roberto. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainView = tabBarController as! TabBarViewController
        
        print(String(describing: mainView.paciente.Peso))
        print(String(describing: mainView.paciente.Altura))
        print(String(describing: mainView.paciente.Edad))
        print(String(describing: mainView.paciente.circAb))
        
        self.definesPresentationContext = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let mainView = tabBarController as! TabBarViewController
        print(String(describing: mainView.paciente.Peso))
        print(String(describing: mainView.paciente.Altura))
        print(String(describing: mainView.paciente.Edad))
        print(String(describing: mainView.paciente.circAb))
    }
}
