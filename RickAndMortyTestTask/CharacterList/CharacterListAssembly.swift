import UIKit

enum CharacterListAssembly {
    static func assemble() -> UIViewController {
        let viewController = CharacterListViewController()
        let presenter = CharacterListPresenter()
        let interactor = CharacterListInteractor()
        let router = CharacterListRouter()
        let collectionViewManager = CharacterListCollectionViewManager()
        let apiClient = RickAndMortyAPIClient()

        viewController.presenter = presenter
        viewController.setCollectionViewManager(collectionViewManager)

        presenter.view = viewController
        presenter.interactor = interactor
        presenter.collectionViewManager = collectionViewManager
        collectionViewManager.delegate = presenter
        presenter.router = router

        interactor.presenter = presenter
        interactor.apiClient = apiClient
        interactor.imageDownloader = apiClient

        router.viewController = viewController
        router.presenter = presenter

        return viewController
    }
}
