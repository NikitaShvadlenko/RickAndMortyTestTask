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
    func fetchCharacterList()
}

// sourcery: AutoMockable
protocol CharacterListInteractorOutput: AnyObject {
    func interactor(_ interactor: CharacterListInteractorInput, didFetchCharacterList list: [CharacterListItem])
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
