import UIKit
// sourcery: AutoMockable
protocol CharacterListViewInput: AnyObject {
    func configureViews()
    func setCollectionViewDelegate(_ delegate: UICollectionViewDelegate)
    func setCollectionViewDataSource(_ dataSource: UICollectionViewDataSource)
    func reloadCollection()
}

protocol CharacterListViewOutput {
    func viewDidLoad(_ view: CharacterListViewInput)
}

// sourcery: AutoMockable
protocol CharacterListInteractorInput {
    func fetchCharacters(for page: Int)
}

// sourcery: AutoMockable
protocol CharacterListInteractorOutput: AnyObject {
   func interactor(
        _ interactor: CharacterListInteractorInput,
        didFetchCharacters result: Result<[CharacterListItem], Error>,
        forPage page: Int
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
