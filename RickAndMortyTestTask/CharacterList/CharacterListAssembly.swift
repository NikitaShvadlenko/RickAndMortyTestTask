import UIKit

enum CharacterListAssembly {
    static func assemble() -> UIViewController {
        let viewController = CharacterListViewController()
        let presenter = CharacterListPresenter()
        let interactor = CharacterListInteractor()
        let router = CharacterListRouter()

        viewController.presenter = presenter

        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router

        interactor.presenter = presenter

        router.viewController = viewController
        router.presenter = presenter

        return viewController
    }
}
