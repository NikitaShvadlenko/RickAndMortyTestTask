//
//  DetailedCharacterViewModel.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 20.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import Foundation

final class DetailedCharacterViewModel: ObservableObject {
    private let characterId: Int
    private let networkClient: ManagesDetailCharacterRequests
    private let imageDownloader: ImageDownloaderProtocol
    @Published var origin: Origin?
    @Published var episodes: [Episode]?
    @Published var imageData: Data?
    @Published var generaInformation: CharacterItem? {
        didSet {
            fetchOrigin()
            fetchEpisodes()
            fetchImageData()
        }
    }

    init(networkClient: ManagesDetailCharacterRequests, imageDownloader: ImageDownloaderProtocol, characterId: Int) {
        self.networkClient = networkClient
        self.characterId = characterId
        self.imageDownloader = imageDownloader
        setGeneralInformation()
    }
}

// MARK: - Private Methods
extension DetailedCharacterViewModel {
    private func setGeneralInformation() {
        Task {
            do {
                let result = try await networkClient.fetchCharacter(characterId: characterId)
                Task { @MainActor in
                    self.generaInformation = result
                }
            } catch {
                print(error)
            }
        }
    }

    private func fetchOrigin() {
        guard let url = generaInformation?.origin.url else {
            self.origin = Origin(name: generaInformation?.origin.name ?? "", type: "")
            return
        }
        Task {
            do {
                let result = try await networkClient.fetchOrigin(from: url)
                Task { @MainActor in
                    self.origin = result
                }
            } catch {
                print(error)
            }
        }
    }

    private func fetchEpisodes() {
        Task {
            guard let episodesUrl = generaInformation?.episode else { return }
            do {
                let result = try await networkClient.fetchEpisodes(from: episodesUrl)
                Task { @MainActor in
                    let formattedEpisodes = convertEpisodesData(
                        episodes: result.sorted(
                            by: {$0.identificator < $1.identificator}
                        )
                    )
                    self.episodes = formattedEpisodes
                }
            } catch {
                print(error)
            }
        }
    }

    private func fetchImageData() {
        Task {
            guard let url = generaInformation?.image else { return }
            do {
                let result = try await imageDownloader.fetchImage(from: url)
                Task { @MainActor in
                    self.imageData = result
                }
            } catch {
                print(error)
            }
        }
    }

    private func convertEpisodesData(episodes: [Episode]) -> [Episode] {
        let pattern = #"S(\d+)E(\d+)"#
        var formattedEpisodes: [Episode] = []
        for episode in episodes {
            let input = episode.episode
            if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
                let range = NSRange(input.startIndex..<input.endIndex, in: input)
                if let match = regex.firstMatch(in: input, options: [], range: range) {
                   guard
                    let seasonRange = Range(match.range(at: 1), in: input),
                    let episodeRange = Range(match.range(at: 2), in: input)
                    else {
                       return formattedEpisodes
                   }
                    let seasonNumber = String(input[seasonRange]).trimmingPrefix(while: { $0 == "0" })
                    let episodeNumber = String(input[episodeRange]).trimmingPrefix(while: { $0 == "0" })

                    formattedEpisodes.append(
                        Episode(
                            name: episode.name,
                            airDate: episode.airDate,
                            episode: "\(L10n.episode): \(episodeNumber), \(L10n.season): \(seasonNumber)",
                            identificator: episode.identificator
                        )
                    )
                }
            }
        }
        return formattedEpisodes
    }
}
