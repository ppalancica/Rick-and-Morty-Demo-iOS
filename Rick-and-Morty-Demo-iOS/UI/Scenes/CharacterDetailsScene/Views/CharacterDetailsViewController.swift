//
//  CharacterDetailsViewController.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 16.02.2023.
//

import UIKit
import FirebaseAuth

protocol CharacterDetailsViewControllerDelegate: AnyObject {
    
    func didSelectCharacter(with viewModel: CharacterViewModelType,
                            inside viewController: CharacterDetailsViewController)
}

final class CharacterDetailsViewController: UIViewController {

    let viewModel: CharacterDetailsViewModelType
    weak var delegate: CharacterDetailsViewControllerDelegate?
    var handle: AuthStateDidChangeListenerHandle?
    
    private lazy var charactersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        layout.itemSize = CGSize(width: 1, height: 1) // The actual size will be configured later
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .white
        
        collectionView.register(
            CharacterCell.self,
            forCellWithReuseIdentifier: CharacterCell.identifier
        )
        
        collectionView.register(
            CollectionViewHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CollectionViewHeaderView.identifier
        )
        
        return collectionView
    }()
    
    init(viewModel: CharacterDetailsViewModelType, delegate: CharacterDetailsViewControllerDelegate) {
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
        
        viewModel.loadSameEpisodeCharacters { [weak self] result in
            self?.charactersCollectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            // reload UI
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if handle != nil {
            Auth.auth().removeStateDidChangeListener(handle!)
        }
    }
}

private extension CharacterDetailsViewController {
    
    func setupUI() {
        title = viewModel.navigationTitle
        view.backgroundColor = .white
        let cellClass = CharacterDetailsCell.self;
        charactersCollectionView.register(cellClass, forCellWithReuseIdentifier: CharacterDetailsCell.identifier)
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
