//
//  File.swift
//  CoordinatorPattern
//
//  Created by paige on 2021/11/16.
//

import UIKit

// MARK: COORDNIATOR PROTOCOL
enum Event {
    case buttonTapped
}

protocol Coordinator {
    var navigationController: UINavigationController? {get set}
    var children: [Coordinator]? { get set }
    
    func eventOccurred(with type: Event)
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}

// MARK: - COORDINATOR
class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var children: [Coordinator]? = nil 
    
    func eventOccurred(with type: Event) {
        switch type {
        case .buttonTapped:
            var vc: UIViewController & Coordinating = SecondViewController()
            vc.coordinator = self 
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func start() {
        var vc: UIViewController & Coordinating = ViewController()
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
    }
}
