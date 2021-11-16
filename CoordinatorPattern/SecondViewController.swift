//
//  SecondViewController.swift
//  CoordinatorPattern
//
//  Created by paige on 2021/11/16.
//

import UIKit

class SecondViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Second"
        view.backgroundColor = .systemBlue
        
 
    }
    
}
