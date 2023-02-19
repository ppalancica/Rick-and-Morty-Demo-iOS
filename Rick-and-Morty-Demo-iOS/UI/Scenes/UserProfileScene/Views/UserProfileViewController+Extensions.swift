//
//  UserProfileViewController+Extensions.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 19.02.2023.
//

import UIKit

// MARK: - UICollectionViewDataSource Methods

fileprivate enum SectionType: Int {
    case userProfile
    case favoriteCharacters
    case logout
}
let sectionTypeCount = 3

extension UserProfileViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionTypeCount
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch section {
            case SectionType.userProfile.rawValue:
                return 1
            
            case SectionType.favoriteCharacters.rawValue:
                return viewModel.characterViewModels.count
            
            case SectionType.logout.rawValue:
                return 1
            
            default:
                fatalError("Illegal state")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
            case SectionType.userProfile.rawValue:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: UserProfileCell.identifier,
                    for: indexPath
                ) as! UserProfileCell
                cell.configureWithViewModel(viewModel)
                return cell
            
            case SectionType.favoriteCharacters.rawValue:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FavoriteCharacterCell.identifier,
                    for: indexPath
                ) as! FavoriteCharacterCell
                let characterViewModel = viewModel.characterViewModels[indexPath.item]
                cell.configureWithViewModel(characterViewModel)
                return cell
            
            case SectionType.logout.rawValue:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: UserLogoutCell.identifier,
                    for: indexPath
                ) as! UserLogoutCell
                cell.delegate = self
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
            
            typedHeaderView.titleLabel.text = "Favorites"
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
            case SectionType.userProfile.rawValue: headerHeight = 0.0
            case SectionType.favoriteCharacters.rawValue: headerHeight = 60.0
            case SectionType.logout.rawValue: headerHeight = 0.0
            default: fatalError("Illegal state")
        }
        
        return CGSize(width: collectionView.frame.width, height: headerHeight)
    }
}

// MARK: - UICollectionViewDelegate Methods

extension UserProfileViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        // ...
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        switch indexPath.section {
            case SectionType.userProfile.rawValue:
                break
            
            case SectionType.favoriteCharacters.rawValue:
                guard let favoriteCharacterCell = cell as? FavoriteCharacterCell else { return }
                let characterViewModel = viewModel.characterViewModels[indexPath.item]
                guard let profileImageUrl = URL(string: characterViewModel.profileImageUrl) else { return }
                favoriteCharacterCell.profileImageView.kf.setImage(with: profileImageUrl)
            
            case SectionType.logout.rawValue:
                break
            
            default:
                fatalError("Illegal state")
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout Methods

extension UserProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat
        let cellHeight: CGFloat
        
        switch indexPath.section {
        case SectionType.userProfile.rawValue:
            cellWidth = view.frame.size.width - 16
            cellHeight = 60
            
        case SectionType.favoriteCharacters.rawValue:
            cellWidth = view.frame.size.width / 2 - 8
            cellHeight = 180
        
        case SectionType.logout.rawValue:
            cellWidth = view.frame.size.width
            cellHeight = 80
            
        default:
            fatalError("Illegal state")
        }
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

// MARK: - UserLogoutCell Methods

extension UserProfileViewController: UserLogoutCellDelegate {
    
    func logoutButtonTapped() {
        
    }
}
