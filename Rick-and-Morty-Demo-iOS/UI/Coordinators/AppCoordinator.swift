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
    
    let charactersService = CharactersService()
    let episodesService = EpisodesService()
    let sessionService = SessionService()
    lazy var bookmarkService = BookmarkService(sessionService: sessionService, charactersService: charactersService)
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
    
//    func navigateToAccountSignup() {
//        let signupVC = SignupViewController(sessionService: sessionService, delegate: self)
//        navigationController.pushViewController(signupVC, animated: true)
//    }
    
    func navigateToAccountSignin() {
        let signinVC = SigninViewController(delegate: self)
        navigationController.pushViewController(signinVC, animated: true)
    }
    
    func navigateToAccountSignupReplacingCurrentView() {
        let signupVC = SignupViewController(delegate: self)
        var viewControllers = navigationController.viewControllers
        viewControllers.removeLast()
        viewControllers.append(signupVC)
        navigationController.viewControllers = viewControllers // Replacing last VC basically
    }
    
    func navigateToAccountSigninReplacingCurrentView() {
        let signinVC = SigninViewController(delegate: self)
        var viewControllers = navigationController.viewControllers
        viewControllers.removeLast()
        viewControllers.append(signinVC)
        navigationController.viewControllers = viewControllers // Replacing last VC basically
    }
    
    func navigateToUserProfile(userProfile: UserProfile) {
        let viewModel = UserProfileViewModel(userProfile: userProfile,
                                             bookmarkService: bookmarkService,
                                             episodesService: episodesService)
        let userProfileVC = UserProfileViewController(viewModel: viewModel, delegate: self)
        navigationController.pushViewController(userProfileVC, animated: true)
    }
    
    func navigateToUserProfileReplacingCurrentView(userProfile: UserProfile) {
        let viewModel = UserProfileViewModel(userProfile: userProfile,
                                             bookmarkService: bookmarkService,
                                             episodesService: episodesService)
        let userProfileVC = UserProfileViewController(viewModel: viewModel, delegate: self)
        var viewControllers = navigationController.viewControllers
        viewControllers.removeLast()
        viewControllers.append(userProfileVC)
        navigationController.viewControllers = viewControllers // Replacing last VC basically
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
            guard let userProfile = sessionService.userProfile else { return }
            navigateToUserProfile(userProfile: userProfile)
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

// MARK: - SignupViewControllerDelegate Methods

extension AppCoordinator: SignupViewControllerDelegate {
    
    func didTapSignup(email: String,
                      password: String,
                      inside viewController: SignupViewController) {
        sessionService.createUser(withEmail: email, password: password) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let userProfile):
                strongSelf.navigateToUserProfileReplacingCurrentView(userProfile: userProfile)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didTapSignin(inside viewController: SignupViewController) {
        navigateToAccountSigninReplacingCurrentView()
    }
}

// MARK: - SigninViewControllerDelegate Methods

extension AppCoordinator: SigninViewControllerDelegate {
    
    func didTapSignin(email: String,
                      password: String,
                      inside viewController: SigninViewController) {
        sessionService.signIn(withEmail: email, password: password) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let userProfile):
                strongSelf.navigateToUserProfileReplacingCurrentView(userProfile: userProfile)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didTapSignup(inside viewController: SigninViewController) {
        navigateToAccountSignupReplacingCurrentView()
    }
}

// MARK: - UserProfileViewControllerDelegate Methods

extension AppCoordinator: UserProfileViewControllerDelegate {
    
    func didTapLogout(inside viewController: UserProfileViewController) {
        sessionService.logout { [weak self] result in
            // For the Demo, we'd assume Log Out always succeeds
            self?.navigationController.popViewController(animated: true)
        }
    }
}
