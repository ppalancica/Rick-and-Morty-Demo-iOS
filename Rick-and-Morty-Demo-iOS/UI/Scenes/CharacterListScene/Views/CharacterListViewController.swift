//
//  CharacterListViewController.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 15.02.2023.
//

import UIKit

protocol CharacterListViewControllerDelegate: AnyObject {
    
    func didSelectCharacter(with viewModel: CharacterViewModelType,
                            inside viewController: CharacterListViewController)
    
    func didTapUserAccountButton(inside viewController: CharacterListViewController)
}

final class CharacterListViewController: UIViewController {
    
    public let viewModel: CharacterListViewModelType
    weak var delegate: CharacterListViewControllerDelegate?
    
    private lazy var charactersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        layout.itemSize = CGSize(width: 1, height: 1) // The actual size will be configured later
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .white
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifier)
        
        return collectionView
    }()
    
    init(viewModel: CharacterListViewModelType, delegate: CharacterListViewControllerDelegate) {
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
        
        viewModel.getAllCharactersViewModels { [weak self] result in
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

private extension CharacterListViewController {
    
    func setupUI() {
        title = "Rick and Morty"
        view.backgroundColor = .white
        // let userImage = UIImage(named: "user-circle-fill")
        let userButton = UIBarButtonItem(title: "Account", // image: userImage
                                         style: .plain,
                                         target: self,
                                         action: #selector(accountButtonTapped))
        navigationItem.leftBarButtonItem = userButton
        let cellClass = CharacterCell.self;
        charactersCollectionView.register(cellClass, forCellWithReuseIdentifier: CharacterCell.identifier)
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
    
    @objc func accountButtonTapped() {
        guard let delegate = delegate else { return }
        
        delegate.didTapUserAccountButton(inside: self)
    }
}
