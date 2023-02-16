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
        navigateToMainCharacterList()
    }
}

// MARK: - Private Methods

private extension CharacterListCoordinator {
    
    func navigateToMainCharacterList() {
        let charactersService = CharactersService()
        let viewModel = CharacterListViewModel(charactersService: charactersService)
        let characterListVC = CharacterListViewController(viewModel: viewModel, delegate: self)
        navigationController.pushViewController(characterListVC, animated: false)
    }
    
    func navigateToCharacterDetails(with viewModel: CharacterViewModel) {
        let charactersService = CharactersService()
//        let viewModel = CharacterListViewModel(charactersService: charactersService)
        let viewModel = CharacterDetailsViewModel(characterViewModel: viewModel)
        let characterDetailsVC = CharacterDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(characterDetailsVC, animated: true)
    }
}

// MARK: - CharacterListViewControllerDelegate Methods

extension CharacterListCoordinator: CharacterListViewControllerDelegate {
 
    func didSelectCharacter(with viewModel: CharacterViewModel) {
        navigateToCharacterDetails(with: viewModel)
    }
}
