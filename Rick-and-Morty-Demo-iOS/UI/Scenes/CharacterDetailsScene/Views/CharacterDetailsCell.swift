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
    lazy var firstSectionLabel = makeFirstSectionLabel()
    lazy var locationLabel = makeLocationLabel()
    lazy var secondSectionLabel = makeSecondSectionLabel()
    lazy var episodeLabel = makeEpisodeLabel()
    lazy var thirdSectionLabel = makeThirdSectionLabel()
    lazy var statusLabel = makeStatusLabel()
    
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
        locationLabel.text = viewModel.location
        episodeLabel.text = viewModel.episode.name
        statusLabel.text = viewModel.status
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
    
    // Section 1
    
    func makeFirstSectionLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .orange
        label.text = "Last visited location:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func makeLocationLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.text = "" // "Earth (C-500A)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    // Section 2
    
    func makeSecondSectionLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .orange
        label.text = "First seen in:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func makeEpisodeLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.text = "" // "Interdimensional Cable"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    // Section 3
    
    func makeThirdSectionLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .orange
        label.text = "Status:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func makeStatusLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.text = "" // "Alive"
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
        labelsStackView.addArrangedSubview(firstSectionLabel)
        labelsStackView.addArrangedSubview(locationLabel)
        labelsStackView.addArrangedSubview(secondSectionLabel)
        labelsStackView.addArrangedSubview(episodeLabel)
        labelsStackView.addArrangedSubview(thirdSectionLabel)
        labelsStackView.addArrangedSubview(statusLabel)
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
