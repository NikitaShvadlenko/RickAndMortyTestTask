import UIKit

protocol CharacterListViewInput: AnyObject {
    func configureViews()
    func displayLoadingOverlay()
    func hideLoadingOverlay()
}

protocol CharacterListViewOutput {
    func viewDidLoad(_ view: CharacterListViewInput)
}

protocol CharacterListInteractorInput {
    func fetchCharacters(for page: Int)
    func fetchImage(url: URL)
}


protocol CharacterListInteractorOutput: AnyObject {
    func interactor(
        _ interactor: CharacterListInteractorInput,
        didFetchCharacters result: Result<[CharacterListItem], Error>,
        forPage page: Int
    )

    func interactor(
        _ interactor: CharacterListInteractorInput,
        didFetchImageData result: Result<Data, Error>,
        forURL url: URL
    )
}

protocol CharacterListRouterInput {
    func routeToDetailedCharacterView(characterID: Int)
}

protocol CharacterListRouterOutput: AnyObject {
}

protocol CharacterListModuleInput: AnyObject {
    func configureModule(output: CharacterListModuleOutput?)
}

// sourcery: AutoMockable
protocol CharacterListModuleOutput: AnyObject {
}
