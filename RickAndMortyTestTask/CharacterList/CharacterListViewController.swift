import UIKit

final class CharacterListViewController: UIViewController {

    private let characterListView = CharacterListView()

    var presenter: CharacterListViewOutput?

    override func loadView() {
        view = characterListView
        setupNavigationBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad(self)
    }

    func setCollectionViewManager(_ manager: ManagesListCollectionView) {
        manager.setCollectionView(characterListView.collectionView)
        characterListView.collectionView.dataSource = manager.dataSource
        characterListView.collectionView.delegate = manager
    }
}

// MARK: - CharacterListViewInput
extension CharacterListViewController: CharacterListViewInput {
    func configureViews() {
    }
}

// MARK: - Private methods
extension CharacterListViewController {
    private func setupNavigationBar() {
let navigaitonBarAppearence = UINavigationBarAppearance()
        title = L10n.characters
        navigaitonBarAppearence.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Asset.white.color]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.standardAppearance = navigaitonBarAppearence
    }
}
