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
        let charactersService = CharactersService()
        let viewModel = CharacterListViewModel(charactersService: charactersService)
        let characterListVC = CharacterListViewController(viewModel: viewModel)
        navigationController.pushViewController(characterListVC, animated: false)
    }
}
