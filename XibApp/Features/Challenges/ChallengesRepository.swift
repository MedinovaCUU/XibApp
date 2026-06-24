import Foundation

protocol ChallengesRepositoryType {
    func fetchChallenges() async throws -> [XibApp.Challenge]
}

struct LocalChallengesRepository: ChallengesRepositoryType {
    func fetchChallenges() async throws -> [XibApp.Challenge] {
        try await Task.sleep(nanoseconds: 200_000_000)
        return XibApp.Challenge.demos
    }
}

final class SupabaseChallengesRepository: ChallengesRepositoryType {
    private let localRepository = LocalChallengesRepository()

    func fetchChallenges() async throws -> [XibApp.Challenge] {
        // TODO: conectar Supabase real cuando el endpoint de challenges este disponible.
        return try await localRepository.fetchChallenges()
    }
}

final class ChallengesRepository {
    private let cacheKey = "xibapp.challenges.cache.v1"
    let remoteURL: URL?

    init(remoteURL: URL? = nil) {
        self.remoteURL = remoteURL
    }

    func loadCached() -> [XibApp.Challenge] {
        guard let data = UserDefaults.standard.data(forKey: cacheKey) else {
            return []
        }
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode([XibApp.Challenge].self, from: data)
        } catch {
            return []
        }
    }

    func saveCache(_ items: [XibApp.Challenge]) {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(items)
            UserDefaults.standard.set(data, forKey: cacheKey)
        } catch {
            // Ignorar errores de cache local.
        }
    }

    func fetchRemote() async throws -> [XibApp.Challenge] {
        guard let url = remoteURL else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode([XibApp.Challenge].self, from: data)
    }

    func refresh() async -> [XibApp.Challenge] {
        if let remote = try? await fetchRemote() {
            saveCache(remote)
            return remote
        }
        let cached = loadCached()
        return cached.isEmpty ? XibApp.Challenge.samples : cached
    }
}
