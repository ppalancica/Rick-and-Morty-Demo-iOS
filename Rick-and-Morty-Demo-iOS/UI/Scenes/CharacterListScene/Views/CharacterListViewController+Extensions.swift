//
//  CharacterListViewController+Extensions.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 15.02.2023.
//

import UIKit

// MARK: - UICollectionViewDataSource Methods

extension CharacterListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.charactersCount
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath) as! CharacterCell
        cell.configureWithViewModel(viewModel.characterViewModel(at: indexPath.item)!)
        return cell
    }
}

// MARK: - UICollectionViewDelegate Methods

extension CharacterListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let delegate = delegate,
              let characterViewModel = viewModel.characterViewModel(at: indexPath.item) else { return }
        
        delegate.didSelectCharacter(with: characterViewModel)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout Methods

extension CharacterListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width - 16, height: 80)
    }
}
