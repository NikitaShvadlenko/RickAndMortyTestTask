//
//  CharacterCell.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 19.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import UIKit

final class CharacterCell: UICollectionViewCell {

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = Asset.blackCard.color
        imageView.addSubview(activityIndicator)
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.8
        label.textColor = Asset.white.color
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        imageView.image = nil
        activityIndicator.startAnimating()
    }
}
// MARK: - Public Methods
extension CharacterCell {
    public func configureName(_ name: String) {
        nameLabel.text = name
    }

    public func configureImage(_ imageData: Data) {
        activityIndicator.stopAnimating()
        imageView.image = UIImage(data: imageData)
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
                nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
                activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
            ]
        )

    }
}
