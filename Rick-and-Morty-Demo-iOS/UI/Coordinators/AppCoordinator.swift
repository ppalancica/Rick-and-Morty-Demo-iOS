//
//  AppCoordinator.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 15.02.2023.
//

import UIKit

class AppCoordinator: Coordinator {
    
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

private extension AppCoordinator {
    
    func navigateToMainCharacterList() {
        let charactersService = CharactersService()
        let episodesService = EpisodesService()
        let viewModel = CharacterListViewModel(charactersService: charactersService,
                                               episodesService: episodesService)
        let characterListVC = CharacterListViewController(viewModel: viewModel, delegate: self)
        navigationController.viewControllers = [characterListVC]
    }
    
    func navigateToCharacterDetails(with viewModel: CharacterViewModelType) {
        let charactersService = CharactersService()
        let episodesService = EpisodesService()
        let viewModel = CharacterDetailsViewModel(characterViewModel: viewModel,
                                                  charactersService: charactersService,
                                                  episodesService: episodesService)
        let characterDetailsVC = CharacterDetailsViewController(viewModel: viewModel, delegate: self)
        navigationController.pushViewController(characterDetailsVC, animated: true)
    }
    
    func navigateToCharacterDetailsReplacingCurrentView(with viewModel: CharacterViewModelType) {
        let charactersService = CharactersService()
        let episodesService = EpisodesService()
        let viewModel = CharacterDetailsViewModel(characterViewModel: viewModel,
                                                  charactersService: charactersService,
                                                  episodesService: episodesService)
        let characterDetailsVC = CharacterDetailsViewController(viewModel: viewModel, delegate: self)
        var viewControllers = navigationController.viewControllers
        viewControllers.removeLast()
        viewControllers.append(characterDetailsVC)
        navigationController.viewControllers = viewControllers // Replacing last VC basically
    }
}

// MARK: - CharacterListViewControllerDelegate Methods

extension AppCoordinator: CharacterListViewControllerDelegate {
 
    func didSelectCharacter(with viewModel: CharacterViewModelType,
                            inside viewController: CharacterListViewController) {
        navigateToCharacterDetails(with: viewModel)
    }
}

// MARK: - CharacterDetailsViewController Methods

extension AppCoordinator: CharacterDetailsViewControllerDelegate {
    
    func didSelectCharacter(with viewModel: CharacterViewModelType,
                            inside viewController: CharacterDetailsViewController) {
        navigateToCharacterDetailsReplacingCurrentView(with: viewModel)
    }
}
