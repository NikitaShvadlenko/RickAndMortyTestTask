import UIKit

enum CharacterListAssembly {
    static func assemble() -> UIViewController {
        let viewController = CharacterListViewController()
        let presenter = CharacterListPresenter()
        let interactor = CharacterListInteractor()
        let router = CharacterListRouter()
        let collectionViewManager = CharacterListCollectionViewManager()

        viewController.presenter = presenter
        viewController.setCollectionViewDelegate(collectionViewManager)
        viewController.setCollectionViewDataSource(collectionViewManager)

        presenter.view = viewController
        presenter.interactor = interactor
        presenter.collectionViewManager = collectionViewManager
        presenter.router = router

        interactor.presenter = presenter

        router.viewController = viewController
        router.presenter = presenter

        return viewController
    }
}
