import Foundation

final class CharacterListPresenter {
    weak var view: CharacterListViewInput?
    weak var moduleOutput: CharacterListModuleOutput?
    var interactor: CharacterListInteractorInput?
    var router: CharacterListRouterInput?
    var collectionViewManager: ManagesListCollectionView?

    private var currentPage = 0
    private var isLoading = false
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
        didFetchCharacters result: Result<[CharacterListItem], Error>,
        forPage page: Int
    ) {
        guard let collectionViewManager else { return }
        switch result {
        case let .success(characters):
            currentPage = page
            collectionViewManager.setCharacterList(with: collectionViewManager.characters + characters)
            view?.reloadCollection()
        case let .failure(error):
            print(error)
        }
        isLoading = false
    }
}
// MARK: - CharacterListCollectionViewManagerDelegate
extension CharacterListPresenter: CharacterListCollectionViewManagerDelegate {
    func characterListCollectionViewManager(
        _ characterListCollectionViewManager: ManagesListCollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print("Selected item")
    }

    func charactersListCollectionNeedsNextPage(_ charactersListCollection: ManagesListCollectionView) {
        loadNextPage()
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
