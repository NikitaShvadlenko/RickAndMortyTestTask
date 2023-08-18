import UIKit

final class CharacterListViewController: UIViewController {

    private let characterListView = CharacterListView()

    var presenter: CharacterListViewOutput?

    override func loadView() {
        view = characterListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad(self)
    }
}

// MARK: - CharacterListViewInput
extension CharacterListViewController: CharacterListViewInput {
    func configureViews() {
    }
}

// MARK: - Private methods
extension CharacterListViewController {
}
