//
//  CharacterListCollectionViewManager.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 19.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import UIKit

protocol ManagesListCollectionView {
    func setMovieCharacterList(with movieCharacterListItems: [MovieCharacterListItem])
}

protocol CharacterListCollectionViewManagerDelegate: AnyObject {
    func characterListCollectionViewManager(
        _ characterListCollectionViewManager: ManagesListCollectionView,
        didSelectItemAt indexPath: IndexPath
    )
}

class CharacterListCollectionViewManager: NSObject {
    weak var delegate: CharacterListCollectionViewManagerDelegate?
    private var characterItems: [MovieCharacterListItem] = [
        MovieCharacterListItem(name: "Rick Snaches"),
        MovieCharacterListItem(name: "Rick Snaches"),
        MovieCharacterListItem(name: "Rick Snaches"),
        MovieCharacterListItem(name: "Rick Snaches"),
        MovieCharacterListItem(name: "Rick Snaches"),
        MovieCharacterListItem(name: "Rick Snaches"),
        MovieCharacterListItem(name: "Rick Snaches"),
        MovieCharacterListItem(name: "Rick Snaches"),
        MovieCharacterListItem(name: "Rick Snaches"),
        MovieCharacterListItem(name: "Rick Snaches"),
        MovieCharacterListItem(name: "Rick Snaches")
    ]
}

extension CharacterListCollectionViewManager: ManagesListCollectionView {
    func setMovieCharacterList(with movieCharacterListItems: [MovieCharacterListItem]) {
        self.characterItems = movieCharacterListItems

    }
}

extension CharacterListCollectionViewManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characterItems.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "\(CharacterCell.self)",
            for: indexPath
        ) as? CharacterCell else {
            fatalError("failed to deqeue cell")
        }
        let item = characterItems[indexPath.row]
        cell.configure(name: item.name, image: item.image!)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.characterListCollectionViewManager(self, didSelectItemAt: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CharacterListCollectionViewManager: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let totalWidth = collectionView.bounds.width - Constants.leftSectionInset * 2
        let availibleWidth = totalWidth - (Constants.spaceBetweenCards * (Constants.numberOfHorizontalCards - 1))
        let width = availibleWidth / Constants.numberOfHorizontalCards
        let height = width * 1.3
        return CGSize(width: width, height: height)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        Constants.collectionViewInsets
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        Constants.spaceBetweenCards
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        Constants.spaceBetweenCards
    }

    private enum Constants {
        static let numberOfHorizontalCards: CGFloat = 2
        static let spaceBetweenCards: CGFloat = 16
        static let leftSectionInset: CGFloat = 20
        static let topSectionInset: CGFloat = 30
        static let verticalSectionInset: CGFloat = 16
        static let collectionViewInsets = UIEdgeInsets(
            top: topSectionInset,
            left: leftSectionInset,
            bottom: verticalSectionInset,
            right: leftSectionInset
        )
    }
}
