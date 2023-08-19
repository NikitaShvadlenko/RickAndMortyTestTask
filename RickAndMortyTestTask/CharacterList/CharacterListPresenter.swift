import Foundation

final class CharacterListPresenter {
    weak var view: CharacterListViewInput?
    weak var moduleOutput: CharacterListModuleOutput?
    var interactor: CharacterListInteractorInput?
    var router: CharacterListRouterInput?
    var collectionViewManager: ManagesListCollectionView?
}

// MARK: - CharacterListViewOutput
extension CharacterListPresenter: CharacterListViewOutput {
    func viewDidLoad(_ view: CharacterListViewInput) {
        view.configureViews()
        interactor?.fetchCharacterList()
    }
}

// MARK: - CharacterListInteractorOutput
extension CharacterListPresenter: CharacterListInteractorOutput {
    func interactor(_ interactor: CharacterListInteractorInput, didFetchCharacterList list: [CharacterItem]) {
        var movieCharacters: [MovieCharacterListItem] = []
        list.forEach { movieCharacters.append(MovieCharacterListItem(name: $0.name))}
        collectionViewManager?.setMovieCharacterList(with: movieCharacters)
        self.view?.reloadCollection()
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
}
