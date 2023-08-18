import UIKit
// sourcery: AutoMockable
protocol CharacterListViewInput: AnyObject {
    func configureViews()
    func setCollectionViewDelegate(_ delegate: UICollectionViewDelegate)
    func setCollectionViewDataSource(_ dataSource: UICollectionViewDataSource)
}

protocol CharacterListViewOutput {
    func viewDidLoad(_ view: CharacterListViewInput)
}

// sourcery: AutoMockable
protocol CharacterListInteractorInput {
}

// sourcery: AutoMockable
protocol CharacterListInteractorOutput: AnyObject {
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
