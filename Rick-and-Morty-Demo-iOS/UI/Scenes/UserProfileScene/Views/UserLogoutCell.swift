//
//  UserLogoutCell.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 19.02.2023.
//

import UIKit

protocol UserLogoutCellDelegate: AnyObject {
    
    func logoutButtonTapped()
}

final class UserLogoutCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    weak var delegate: UserLogoutCellDelegate?
    
    lazy var logoutButton = makeLogoutButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension UserLogoutCell {
    
    func makeLogoutButton() -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.layer.cornerRadius = 8
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Log Out", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
        
    func setupUI() {
        contentView.addSubview(logoutButton)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    @objc func logoutButtonTapped() {
        guard let delegate = delegate else { return }
        delegate.logoutButtonTapped()
    }
    
    func configureConstraints() {
        logoutButton.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        logoutButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        logoutButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        logoutButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
    }
}
