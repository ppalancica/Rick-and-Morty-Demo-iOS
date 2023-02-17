//
//  CharacterDetailsViewController.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 16.02.2023.
//

import UIKit

final class CharacterDetailsViewController: UIViewController {

    let viewModel: CharacterDetailsViewModelType
    
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
    
    init(viewModel: CharacterDetailsViewModelType) {
        self.viewModel = viewModel
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
