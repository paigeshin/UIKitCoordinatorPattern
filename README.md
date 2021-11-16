# UIKitCoordinatorPattern

[Coordinator](https://www.notion.so/Coordinator-0e3b9e909c06440a84267d27855c8245)


# Configure Project

- Delete `Main Storyboard file base name`
- Delete `Storyboard Name` in Application Scene Manifest

# Protocol

```swift
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
```

# AppDelegate

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navVC = UINavigationController()
        let coordinator = MainCoordinator()
        coordinator.navigationController = navVC
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navVC
        window.makeKeyAndVisible()
        self.window = window
        
        coordinator.start()
        
        return true
    }
```

# SceneDeleagte

- If you need multi-window support

```swift
// for multi window support
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      guard let windowScene = (scene as? UIWindowScene) else { return }
      
      let navVC = UINavigationController()
      let coordinator = MainCoordinator()
      coordinator.navigationController = navVC
      
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = navVC
      window.makeKeyAndVisible()
      self.window = window
      
      coordinator.start()
  }
```

# ViewController

```swift
//
//  ViewController.swift
//  CoordinatorPattern
//
//  Created by paige on 2021/11/16.
//

import UIKit

class ViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        title = "Home"
    
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 220, height: 55))
        view.addSubview(button)
        button.center = view.center
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.setTitle("Tap Me!", for: .normal)
    }

    @objc
    func didTapButton() {
        coordinator?.eventOccurred(with: .buttonTapped)
    }
    
}
```

# SecondViewController

```swift
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
```
