//
//  UserProfileCell.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 19.02.2023.
//

import UIKit

final class UserProfileCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    lazy var profileImageView = makeProfileImageView()
    lazy var emailLabel = makeEmailLabel()
    lazy var labelsStackView = makeLabelsStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWithViewModel(_ viewModel: UserProfileViewModel) {
        emailLabel.text = viewModel.email
    }
}

private extension UserProfileCell {
    
    func makeProfileImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "user-circle-fill")
        return imageView
    }
    
    func makeEmailLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .orange
        label.text = "" // "pavel001@gmail.com"
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
        labelsStackView.addArrangedSubview(emailLabel)
        contentView.addSubview(labelsStackView)
    }
    
    func configureConstraints() {
        // Profile Image
        profileImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        // Stack View
        labelsStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        labelsStackView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        labelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        labelsStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
}
