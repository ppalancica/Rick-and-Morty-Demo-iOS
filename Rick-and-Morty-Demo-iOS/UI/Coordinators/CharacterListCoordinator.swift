//
//  CharacterListCoordinator.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 15.02.2023.
//

import UIKit

class CharacterListCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let characterListVC = CharacterListViewController()
        navigationController.pushViewController(characterListVC, animated: false)
    }
}
