//
//  UserProfileViewController.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 18.02.2023.
//

import UIKit

protocol UserProfileViewControllerDelegate: AnyObject {
        
    func didTapLogout(inside viewController: UserProfileViewController)
}

final class UserProfileViewController: UIViewController {
    
    public let viewModel: UserProfileViewModel
    
    weak var delegate: UserProfileViewControllerDelegate?
    
    private lazy var charactersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        layout.itemSize = CGSize(width: 1, height: 1) // The actual size will be configured later
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    init(viewModel: UserProfileViewModel, delegate: UserProfileViewControllerDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
        configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getAllBookmarkedCharacters { [weak self] result in
            switch result {
            case .success(let characterViewModels):
                print(characterViewModels)
                self?.charactersCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

private extension UserProfileViewController {
    
    func setupUI() {
        title = "User Profile"
        view.backgroundColor = .white
        
        charactersCollectionView.register(
            UserProfileCell.self,
            forCellWithReuseIdentifier: UserProfileCell.identifier
        )
        
        charactersCollectionView.register(
            FavoriteCharacterCell.self,
            forCellWithReuseIdentifier: FavoriteCharacterCell.identifier
        )
        
        charactersCollectionView.register(
            UserLogoutCell.self,
            forCellWithReuseIdentifier: UserLogoutCell.identifier
        )
        
        charactersCollectionView.register(
            CollectionViewHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CollectionViewHeaderView.identifier
        )
        
        charactersCollectionView.dataSource = self
        charactersCollectionView.delegate = self
        view.addSubview(charactersCollectionView)
    }
    
    func configureConstraints() {
        charactersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        charactersCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        charactersCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        charactersCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        charactersCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
