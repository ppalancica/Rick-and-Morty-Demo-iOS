//
//  FavoriteCharacterCell.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 19.02.2023.
//

import UIKit

final class FavoriteCharacterCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    lazy var profileImageView = makeProfileImageView()
    lazy var nameLabel = makeNameLabel()
    lazy var episodeLabel = makeEpisodeLabel()
    lazy var firstEpisodeNameLabel = makeFirstEpisodeNameLabel()
    
    lazy var labelsStackView = makeLabelsStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWithViewModel(_ viewModel: FavoriteCharacterCellViewModelType) {
        nameLabel.text = viewModel.name
        firstEpisodeNameLabel.text = viewModel.episode.name
    }
}

private extension FavoriteCharacterCell {
    
    func makeProfileImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    func makeNameLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .orange
        label.text = "" // "Eyehole Man"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
        
    func makeEpisodeLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.text = "Episode"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func makeFirstEpisodeNameLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.text = "" // "Pilot"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func makeLabelsStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    func setupUI() {
        // Add image
        contentView.addSubview(profileImageView)
        // Add labels to stack
        labelsStackView.addArrangedSubview(nameLabel)
        labelsStackView.addArrangedSubview(episodeLabel)
        labelsStackView.addArrangedSubview(firstEpisodeNameLabel)
        contentView.addSubview(labelsStackView)
    }
    
    func configureConstraints() {
        // Profile Image
        profileImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        profileImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        // Stack View
        labelsStackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8).isActive = true
        labelsStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        labelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        labelsStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
    }
}
