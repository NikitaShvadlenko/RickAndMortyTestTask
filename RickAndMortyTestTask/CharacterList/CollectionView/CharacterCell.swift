//
//  CharacterCell.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 19.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import UIKit

// TODO: Spinner while loading image, placeholder image if failed

final class CharacterCell: UICollectionViewCell {

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .red
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textColor = Asset.white.color
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Public Methods
extension CharacterCell {
    public func configure(name: String, image: UIImage) {
        nameLabel.text = name
        imageView.image = image
    }
}

// MARK: - Private Methods
extension CharacterCell {
    private func setupView() {
        contentView.backgroundColor = Asset.blackCard.color
        contentView.layer.cornerRadius = 16
        [
            nameLabel,
            imageView
        ].forEach(contentView.addSubview(_:))

        NSLayoutConstraint.activate(
            [
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -16),
                nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            ]
        )

    }
}
