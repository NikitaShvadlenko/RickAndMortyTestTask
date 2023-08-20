import UIKit
import SwiftUI

final class CharacterListRouter {
    weak var viewController: UIViewController?
    weak var presenter: CharacterListRouterOutput?
}

// MARK: - CharacterListRouterInput
extension CharacterListRouter: CharacterListRouterInput {
    func routeToDetailedCharacterView(characterID: Int) {
        let characterDetailView = DetailCharacterAssembly.assemble(characterID: characterID)
        let hostingController = UIHostingController(rootView: characterDetailView)
        viewController?.navigationController?.pushViewController(hostingController, animated: true)
    }
}

// MARK: - Private methods
extension CharacterListRouter {
}
