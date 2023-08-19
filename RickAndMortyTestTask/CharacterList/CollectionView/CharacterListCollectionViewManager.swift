//
//  CharacterListCollectionViewManager.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 19.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import UIKit

protocol ManagesListCollectionView {
    var characters: [CharacterListItem] { get }
    var delegate: CharacterListCollectionManagerDelegate? { get set }
    func setCharacterList(with movieCharacterListItems: [CharacterListItem])
}

protocol CharacterListCollectionManagerDelegate: AnyObject {
    func characterListCollectionManager(
        _ characterListCollectionManager: ManagesListCollectionView,
        didSelectItemAt indexPath: IndexPath
    )

    func characterListCollectionManager(
        _ characterListCollectionManager: ManagesListCollectionView,
        needsImageFor indexPath: IndexPath,
        completion: @escaping (_ imageData: Data) -> Void
    )

    func characterListCollectionManagerNeedsNextPage(
        _ characterListCollectionManager: ManagesListCollectionView
    )
}

class CharacterListCollectionViewManager: NSObject {
    weak var delegate: CharacterListCollectionManagerDelegate?
    private(set) var characters: [CharacterListItem] = []
    private var imageWaitingIndexPaths = Set<IndexPath>()
}

extension CharacterListCollectionViewManager: ManagesListCollectionView {
    func setCharacterList(with movieCharacterListItems: [CharacterListItem]) {
        characters = movieCharacterListItems

    }
}

// TODO: Implement Diffable Data Source
extension CharacterListCollectionViewManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
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
        let item = characters[indexPath.row]
        cell.configureName(item.name)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.characterListCollectionManager(self, didSelectItemAt: indexPath)
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

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.bounds.size.height - 100) {
            delegate?.characterListCollectionManagerNeedsNextPage(self)
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        imageWaitingIndexPaths.insert(indexPath)
        let cell = cell as? CharacterCell
        delegate?.characterListCollectionManager(
            self,
            needsImageFor: indexPath,
            completion: { [weak self, weak cell] (imageData: Data) in
                guard self?.imageWaitingIndexPaths.contains(indexPath) == true else { return }
                self?.imageWaitingIndexPaths.remove(indexPath)
                cell?.configureImage(imageData)
            }
        )
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        imageWaitingIndexPaths.remove(indexPath)
    }
}

// MARK: - Constants
extension CharacterListCollectionViewManager {
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
