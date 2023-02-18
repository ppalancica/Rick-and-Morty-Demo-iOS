//
//  AppCoordinator.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 15.02.2023.
//

import UIKit
import FirebaseAuth

class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigateToMainCharacterList()
    }
    
    let charactersService = CharactersService()
    let episodesService = EpisodesService()
    let bookmarkService = BookmarkService()
    let sessionService = SessionService()
}

// MARK: - Private Methods (Rick and Morty UI Browsing)

private extension AppCoordinator {
    
    func navigateToMainCharacterList() {
        let viewModel = CharacterListViewModel(charactersService: charactersService,
                                               episodesService: episodesService)
        let characterListVC = CharacterListViewController(viewModel: viewModel, delegate: self)
        navigationController.viewControllers = [characterListVC]
    }
    
    func navigateToCharacterDetails(with viewModel: CharacterViewModelType) {
        let viewModel = CharacterDetailsViewModel(characterViewModel: viewModel,
                                                  charactersService: charactersService,
                                                  episodesService: episodesService,
                                                  bookmarkService: bookmarkService,
                                                  sessionService: sessionService)
        let characterDetailsVC = CharacterDetailsViewController(viewModel: viewModel, delegate: self)
        navigationController.pushViewController(characterDetailsVC, animated: true)
    }
    
    func navigateToCharacterDetailsReplacingCurrentView(with viewModel: CharacterViewModelType) {
        let viewModel = CharacterDetailsViewModel(characterViewModel: viewModel,
                                                  charactersService: charactersService,
                                                  episodesService: episodesService,
                                                  bookmarkService: bookmarkService,
                                                  sessionService: sessionService)
        let characterDetailsVC = CharacterDetailsViewController(viewModel: viewModel, delegate: self)
        var viewControllers = navigationController.viewControllers
        viewControllers.removeLast()
        viewControllers.append(characterDetailsVC)
        navigationController.viewControllers = viewControllers // Replacing last VC basically
    }
}

// MARK: - Private Methods (Account Management)

private extension AppCoordinator {
    
    func navigateToAccountSignup() {
        
    }
    
    func navigateToAccountSignin() {
        let signinVC = SigninViewController(delegate: self)
        navigationController.pushViewController(signinVC, animated: true)
    }
    
    func navigateToAccountDetails() {
        
    }
}


// MARK: - CharacterListViewControllerDelegate Methods

extension AppCoordinator: CharacterListViewControllerDelegate {
 
    func didSelectCharacter(with viewModel: CharacterViewModelType,
                            inside viewController: CharacterListViewController) {
        navigateToCharacterDetails(with: viewModel)
    }
    
    func didTapUserAccountButton(inside viewController: CharacterListViewController) {
        if sessionService.isUserLoggedIn {
            navigateToAccountDetails()
        } else {
            navigateToAccountSignin()
        }
    }
}

// MARK: - CharacterDetailsViewControllerDelegate Methods

extension AppCoordinator: CharacterDetailsViewControllerDelegate {
    
    func didSelectCharacter(with viewModel: CharacterViewModelType,
                            inside viewController: CharacterDetailsViewController) {
        navigateToCharacterDetailsReplacingCurrentView(with: viewModel)
    }
}

// MARK: - SigninViewControllerDelegate Methods

extension AppCoordinator: SigninViewControllerDelegate {
    
    func didTapSignin(email: String,
                      password: String,
                      inside viewController: SigninViewController) {
        
    }
    
    func didTapSignup(inside viewController: SigninViewController) {
        // Switch to Signup View
    }
}
