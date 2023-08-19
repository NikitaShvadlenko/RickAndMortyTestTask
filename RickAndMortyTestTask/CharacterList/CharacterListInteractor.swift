import Foundation

final class CharacterListInteractor {
    weak var presenter: CharacterListInteractorOutput?
    var apiClient: RickAndMortyAPIClientProtocol?
}

// MARK: - CharacterListInteractorInput
extension CharacterListInteractor: CharacterListInteractorInput {
    func fetchCharacterList() {
        guard let apiClient = apiClient else { return }
        Task {
            do {
                let result = try await apiClient.fetchCharacters()
                print("Pages amount:", result.info.pages)
                presenter?.interactor(self, didFetchCharacterList: result.results)
            } catch {
                print(error)
            }
        }
    }
}

// MARK: - Private methods
extension CharacterListInteractor {
}
