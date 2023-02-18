//
//  SignupViewController.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 18.02.2023.
//

import UIKit
import FirebaseAuth

protocol SignupViewControllerDelegate: AnyObject {

}

final class SignupViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        /*let email = "pavel002@gmail.com"
        let password = "pavel002"

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            // ...
        }*/
    }
}
