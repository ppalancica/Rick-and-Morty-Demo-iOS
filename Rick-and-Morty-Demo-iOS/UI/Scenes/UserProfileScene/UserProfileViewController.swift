//
//  UserProfileViewController.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 18.02.2023.
//

import UIKit

final class UserProfileViewController: UIViewController {
    
    private let email: String

    init(email: String) {
        self.email = email
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupViews()
        setupLayoutConstraints()
    }
}


private extension UserProfileViewController {
    func setupViews() {
        title = "User Profile"
        view.backgroundColor = .white
        print("UserProfile[email=\(email)]")
    }
    
    func setupLayoutConstraints() {
        
    }
}
