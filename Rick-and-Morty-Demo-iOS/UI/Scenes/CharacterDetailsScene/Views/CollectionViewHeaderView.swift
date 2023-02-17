//
//  CollectionViewHeaderView.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 17.02.2023.
//

import UIKit

class CollectionViewHeaderView: UICollectionReusableView {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    lazy var titleLabel = makeTitleLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setupUI()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

private extension CollectionViewHeaderView {
    
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = "Also from EPISODE_NAME"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func setupUI() {
        backgroundColor = .lightGray
        addSubview(titleLabel)
    }
    
    func configureConstraints() {
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 8).isActive = true
    }
}
