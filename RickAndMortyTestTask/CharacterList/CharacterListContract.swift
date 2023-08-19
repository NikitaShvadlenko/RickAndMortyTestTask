import UIKit
// sourcery: AutoMockable
protocol CharacterListViewInput: AnyObject {
    func configureViews()
}

protocol CharacterListViewOutput {
    func viewDidLoad(_ view: CharacterListViewInput)
}

// sourcery: AutoMockable
protocol CharacterListInteractorInput {
    func fetchCharacters(for page: Int)
    func fetchImage(url: URL)
}

// sourcery: AutoMockable
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

// sourcery: AutoMockable
protocol CharacterListRouterInput {
}

protocol CharacterListRouterOutput: AnyObject {
}

protocol CharacterListModuleInput: AnyObject {
    func configureModule(output: CharacterListModuleOutput?)
}

// sourcery: AutoMockable
protocol CharacterListModuleOutput: AnyObject {
}
