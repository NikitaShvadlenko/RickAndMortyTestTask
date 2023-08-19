import Foundation

final class CharacterListPresenter {
    weak var view: CharacterListViewInput?
    weak var moduleOutput: CharacterListModuleOutput?
    var interactor: CharacterListInteractorInput?
    var router: CharacterListRouterInput?
    var collectionViewManager: ManagesListCollectionView?

    private var currentPage = 0
    private var isLoading = false
    private var loadImageCompletions: [URL: (Data) -> Void] = [:]
}

// MARK: - CharacterListViewOutput
extension CharacterListPresenter: CharacterListViewOutput {
    func viewDidLoad(_ view: CharacterListViewInput) {
        view.configureViews()
    }
}

// MARK: - CharacterListInteractorOutput
extension CharacterListPresenter: CharacterListInteractorOutput {
    func interactor(
        _ interactor: CharacterListInteractorInput,
        didFetchImageData result: Result<Data, Error>,
        forURL url: URL
    ) {
        switch result {
        case let .success(data):
            let completion = loadImageCompletions[url]
            loadImageCompletions.removeValue(forKey: url)
            completion?(data)

        case .failure:
            break
        }
    }

    func interactor(
        _ interactor: CharacterListInteractorInput,
        didFetchCharacters result: Result<[CharacterListItem], Error>,
        forPage page: Int
    ) {
        guard let collectionViewManager else { return }
        switch result {
        case let .success(characters):
            currentPage = page
            collectionViewManager.setCharacterList(with: collectionViewManager.characters + characters)
        case let .failure(error):
            print(error)
        }
        isLoading = false
    }
}
// MARK: - CharacterListCollectionViewManagerDelegate
extension CharacterListPresenter: CharacterListCollectionManagerDelegate {
    func characterListCollectionManagerNeedsNextPage(_ characterListCollectionManager: ManagesListCollectionView) {
        loadNextPage()
    }

    func characterListCollectionManager(
        _ characterListCollectionManager: ManagesListCollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let collectionViewManager else { return }
        // will pass id to swiftUI view, so it can make the detailed request itself
        print("Selected Item with id: \(collectionViewManager.characters[indexPath.item].id)")
    }

    func characterListCollectionManager(
        _ characterListCollectionManager: ManagesListCollectionView,
        needsImageFor indexPath: IndexPath,
        completion: @escaping (Data) -> Void) {
            guard let collectionViewManager else { return }
            let url = collectionViewManager.characters[indexPath.item].image
            loadImageCompletions[url] = completion
            interactor?.fetchImage(url: url)
    }

    func characterListCollectionViewManagerNeedsNextPage(
        _ characterListCollectionViewManager: ManagesListCollectionView) {

    }
}
// MARK: - CharacterListRouterOutput
extension CharacterListPresenter: CharacterListRouterOutput {
}

// MARK: - CharacterListModuleInput
extension CharacterListPresenter: CharacterListModuleInput {
    func configureModule(output: CharacterListModuleOutput?) {
        self.moduleOutput = output
    }
}

// MARK: - Private methods
extension CharacterListPresenter {
    private func loadNextPage() {
        if isLoading { return }
        isLoading = true
        interactor?.fetchCharacters(for: currentPage + 1)
    }
}
