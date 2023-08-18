import Foundation

final class CharacterListPresenter {
    weak var view: CharacterListViewInput?
    weak var moduleOutput: CharacterListModuleOutput?
    var interactor: CharacterListInteractorInput?
    var router: CharacterListRouterInput?
}

// MARK: - CharacterListViewOutput
extension CharacterListPresenter: CharacterListViewOutput {
    func viewDidLoad(_ view: CharacterListViewInput) {
        view.configureViews()
    }
}

// MARK: - CharacterListInteractorOutput
extension CharacterListPresenter: CharacterListInteractorOutput {
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
