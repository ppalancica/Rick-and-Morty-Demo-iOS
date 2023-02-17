//
//  CharacterDetailsViewController+Extensions.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 16.02.2023.
//

import UIKit

// MARK: - UICollectionViewDataSource Methods

fileprivate enum SectionType: Int {
    case characterDetails
    case sameEpisodeCharacters
}

extension CharacterDetailsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sameEpisodeCharacters.count > 0 ? 2 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch section {
            case SectionType.characterDetails.rawValue:
                return 1
            case SectionType.sameEpisodeCharacters.rawValue:
                return viewModel.sameEpisodeCharacters.count
            default:
                fatalError("Illegal state")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
            case SectionType.characterDetails.rawValue:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterDetailsCell.identifier, for: indexPath) as! CharacterDetailsCell
                cell.configureWithViewModel(viewModel.selectedCharacterViewModel)
                return cell
            case SectionType.sameEpisodeCharacters.rawValue:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath) as! CharacterCell
                let characterViewModel = viewModel.sameEpisodeCharacters[indexPath.item]
                cell.configureWithViewModel(characterViewModel)
                return cell
            default:
                fatalError("Illegal state")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
      
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: CollectionViewHeaderView.identifier,
                for: indexPath
            )
            
            guard let typedHeaderView = headerView as? CollectionViewHeaderView else {
                return headerView
            }

            let episodeName = viewModel.selectedCharacterViewModel.episode.name
            typedHeaderView.titleLabel.text = "Also from \(episodeName)"
            return typedHeaderView

        default:
            fatalError("Illegal state")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let headerHeight: CGFloat
        
        switch section {
            case SectionType.characterDetails.rawValue:
                headerHeight = 0.0
            case SectionType.sameEpisodeCharacters.rawValue:
                headerHeight = 60.0
            default:
                fatalError("Illegal state")
        }
        
        return CGSize(width: collectionView.frame.width, height: headerHeight)
    }
}

// MARK: - UICollectionViewDelegate Methods

extension CharacterDetailsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard indexPath.section == 1 else { return }
        
        guard let delegate = delegate,
              let characterViewModel = viewModel.sameEpisodeCharacterViewModel(at: indexPath.item) else { return }
        
        delegate.didSelectCharacter(with: characterViewModel, inside: self)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout Methods

extension CharacterDetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight: CGFloat
        
        switch indexPath.section {
        case SectionType.characterDetails.rawValue:
            cellHeight = 120
        case SectionType.sameEpisodeCharacters.rawValue:
            cellHeight = 80
        default:
            fatalError("Illegal state")
        }
        
        return CGSize(width: view.frame.size.width - 16, height: cellHeight)
    }
}
