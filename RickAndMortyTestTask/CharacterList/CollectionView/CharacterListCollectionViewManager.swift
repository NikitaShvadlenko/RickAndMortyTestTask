//
//  CharacterListCollectionViewManager.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 19.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import UIKit

enum Section {
    case main
}

protocol ManagesListCollectionView: UICollectionViewDelegate {
    var characters: [CharacterListItem] { get }
    var delegate: CharacterListCollectionManagerDelegate? { get set }
    var dataSource: UICollectionViewDiffableDataSource<Section, CharacterListItem> { get }
    func setCharacterList(with movieCharacterListItems: [CharacterListItem])
    func setCollectionView(_ collectionView: UICollectionView)
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

final class CharacterListCollectionViewManager: NSObject {
    weak var delegate: CharacterListCollectionManagerDelegate?
    private(set) var characters: [CharacterListItem] = [] {
        didSet {
            configureSnapshot()
        }
    }
    private var imageWaitingIndexPaths = Set<IndexPath>()

    weak var collecitonView: UICollectionView?
    lazy var dataSource: UICollectionViewDiffableDataSource<Section, CharacterListItem> = {
        guard let collectionView = self.collecitonView else {
            fatalError("CollectionView was not set")
        }

        let cellRegistration = UICollectionView
            .CellRegistration<CharacterCell, CharacterListItem> { (cell, _, item) in
                cell.configureName(item.name)
            }

        return UICollectionViewDiffableDataSource<Section, CharacterListItem>(
            collectionView: collectionView
            // swiftlint:disable line_length
        ) { (collectionView: UICollectionView, indexPath: IndexPath, identifier: CharacterListItem) -> UICollectionViewCell? in

            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: identifier
            )
        }
    }()
}

extension CharacterListCollectionViewManager: ManagesListCollectionView {
    func setCollectionView(_ collectionView: UICollectionView) {
        self.collecitonView = collectionView
    }

    func setCharacterList(with movieCharacterListItems: [CharacterListItem]) {
        characters = movieCharacterListItems

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

// MARK: - Private Methods
extension CharacterListCollectionViewManager {
    private func configureSnapshot() {
        let section = Section.main
        var snapshot = NSDiffableDataSourceSnapshot<Section, CharacterListItem>()
        snapshot.appendSections([section])
        snapshot.appendItems(characters)
        dataSource.apply(snapshot, animatingDifferences: false)
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
