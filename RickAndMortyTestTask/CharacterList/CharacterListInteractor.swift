import Foundation

final class CharacterListInteractor {
    weak var presenter: CharacterListInteractorOutput?
    var apiClient: RickAndMortyAPIClientProtocol?
    var imageDownloader: ImageDownloaderProtocol?
    private let imageCache = NSCache<NSURL, NSData>()
}

// MARK: - CharacterListInteractorInput
extension CharacterListInteractor: CharacterListInteractorInput {
    func fetchImage(url: URL) {
        if let data = imageCache.object(forKey: url as NSURL) as Data? {
            presenter?.interactor(
                self,
                didFetchImageData: .success(data),
                forURL: url
            )
            return
        }

        guard let imageDownloader = imageDownloader else { return }
        Task {
            do {
                let result = try await imageDownloader.fetchImage(from: url)
                Task { @MainActor in
                    self.imageCache.setObject(result as NSData, forKey: url as NSURL)
                    presenter?.interactor(self, didFetchImageData: .success(result), forURL: url)
                }
            } catch {
                presenter?.interactor(self, didFetchImageData: .failure(error), forURL: url)
            }
        }
    }

    func fetchCharacters(for page: Int) {
        guard let apiClient = apiClient else { return }
        Task {
            do {
                let result = try await apiClient.fetchCharacters(for: page)
                Task { @MainActor in
                    presenter?.interactor(self, didFetchCharacters: .success(result.results), forPage: page)
                }
            } catch {
                presenter?.interactor(self, didFetchCharacters: .failure(error), forPage: page)
            }
        }
    }
}

// MARK: - Private methods
extension CharacterListInteractor {
}
