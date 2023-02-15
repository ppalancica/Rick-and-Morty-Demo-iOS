//
//  CharacterListViewController.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 15.02.2023.
//

import UIKit

final class CharacterListViewController: UIViewController {
    
    let viewModel: CharacterListViewModelType
    
    init(viewModel: CharacterListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = "Rick and Morty"
        view.backgroundColor = .white
        
        viewModel.getAllCharactersViewModels { result in
            switch result {
            case .success(let characterViewModels):
                print(characterViewModels)
            case .failure(let error):
                print(error)
            }
        }
    }
}
