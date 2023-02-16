//
//  CharacterDetailsCell.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 16.02.2023.
//

import UIKit

final class CharacterDetailsCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    lazy var profileImageView = makeProfileImageView()
    lazy var nameLabel = makeNameLabel()
    lazy var locationLabel = makeLocationLabel()
    lazy var episodeLabel = makeEpisodeLabel()
    
    lazy var labelsStackView = makeLabelsStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWithViewModel(_ viewModel: CharacterViewModelType) {
        nameLabel.text = viewModel.name
        locationLabel.text = viewModel.location
    }
}

private extension CharacterDetailsCell {
    
    func makeProfileImageView() -> UIImageView {
        let imageView = UIImageView()
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
    
    func makeLocationLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.text = "" // "Earth (C-500A)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func makeEpisodeLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.text = "Episode"
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
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(episodeLabel)
        // Add labels to stack
        labelsStackView.addArrangedSubview(nameLabel)
        labelsStackView.addArrangedSubview(locationLabel)
        labelsStackView.addArrangedSubview(episodeLabel)
        contentView.addSubview(labelsStackView)
    }
    
    func configureConstraints() {
        // Profile Image
        profileImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        // Stack View
        labelsStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        labelsStackView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        labelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        labelsStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
}
