import Foundation
import Supabase

private func normalizedNonEmpty(_ value: String?) -> String? {
    guard let value else { return nil }
    let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
    return trimmed.isEmpty ? nil : trimmed
}

private func extractedTechniqueFromName(_ rawName: String) -> String? {
    guard let range = rawName.range(of: " - ") else {
        return nil
    }
    let suffix = String(rawName[range.upperBound...]).trimmingCharacters(in: .whitespacesAndNewlines)
    return suffix.isEmpty ? nil : suffix
}

private func cleanedExerciseName(_ rawName: String) -> String {
    guard let range = rawName.range(of: " - ") else {
        return rawName.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    return String(rawName[..<range.lowerBound]).trimmingCharacters(in: .whitespacesAndNewlines)
}

// MARK: Models
struct MuscleDTO: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let image_url: String?
}

struct EquipmentDTO: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let icon_url: String?
}

struct ExerciseDetailDTO: Codable, Identifiable, Equatable {
    let id: String
    let slug: String
    let name: String
    let technique: String?
    let primary_media_url: String?
    let media_type: String?
    let similar_names: [String]?
    let instructions: [String]?
    let muscles: [MuscleDTO]
    let equipment: [EquipmentDTO]

    var displayName: String {
        cleanedExerciseName(name)
    }

    var displayTechnique: String? {
        normalizedNonEmpty(technique) ?? extractedTechniqueFromName(name)
    }
}

struct ExerciseCatalogItemDTO: Codable, Identifiable, Hashable {
    let id: String
    let slug: String
    let name: String
    let technique: String?
    let primary_media_url: String?
    let similar_names: [String]?
    let muscles: [MuscleDTO]
    let equipment: [EquipmentDTO]

    var displayName: String {
        cleanedExerciseName(name)
    }

    var displayTechnique: String? {
        normalizedNonEmpty(technique) ?? extractedTechniqueFromName(name)
    }
}

enum ExerciseRepositoryError: LocalizedError {
    case localSeedNotFound
    case localSeedDecodeFailed
    case notFound(String)

    var errorDescription: String? {
        switch self {
        case .localSeedNotFound:
            return "No se encontró el catálogo local de ejercicios."
        case .localSeedDecodeFailed:
            return "No se pudo leer el catálogo local de ejercicios."
        case .notFound(let slug):
            return "No se encontró el ejercicio: \(slug)."
        }
    }
}

// MARK: Local Seed Data Source
final class LocalExerciseLibraryDataSource {
    private let bundle: Bundle
    private let resourceName: String
    private var cachedDetails: [ExerciseDetailDTO]?

    init(bundle: Bundle = .main, resourceName: String = "exercise_detail_v1_seed") {
        self.bundle = bundle
        self.resourceName = resourceName
    }

    func loadAll() throws -> [ExerciseDetailDTO] {
        if let cachedDetails {
            return cachedDetails
        }

        guard let url = bundle.url(forResource: resourceName, withExtension: "json") else {
            throw ExerciseRepositoryError.localSeedNotFound
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([ExerciseDetailDTO].self, from: data)
            cachedDetails = decoded
            return decoded
        } catch {
            throw ExerciseRepositoryError.localSeedDecodeFailed
        }
    }

    func fetchCatalog(searchText: String) throws -> [ExerciseCatalogItemDTO] {
        let all = try loadAll()
        let query = normalized(searchText)
        let filtered = query.isEmpty ? all : all.filter { matches($0, query: query) }
        return filtered.map { detail in
            ExerciseCatalogItemDTO(
                id: detail.id,
                slug: detail.slug,
                name: detail.name,
                technique: detail.technique,
                primary_media_url: detail.primary_media_url,
                similar_names: detail.similar_names,
                muscles: detail.muscles,
                equipment: detail.equipment
            )
        }
    }

    func fetchDetail(slug: String) throws -> ExerciseDetailDTO {
        let all = try loadAll()
        let normalizedSlug = normalized(slug)
        guard let item = all.first(where: { normalized($0.slug) == normalizedSlug }) else {
            throw ExerciseRepositoryError.notFound(slug)
        }
        return item
    }

    private func matches(_ detail: ExerciseDetailDTO, query: String) -> Bool {
        let searchableChunks: [String] = [
            detail.name,
            detail.displayName,
            detail.displayTechnique ?? "",
            detail.slug,
            (detail.similar_names ?? []).joined(separator: " "),
            detail.muscles.map(\.name).joined(separator: " "),
            detail.equipment.map(\.name).joined(separator: " ")
        ]

        let blob = normalized(searchableChunks.joined(separator: " "))
        return blob.contains(query)
    }

    private func normalized(_ value: String) -> String {
        value
            .folding(options: [.caseInsensitive, .diacriticInsensitive], locale: .current)
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// MARK: Repository
protocol ExerciseRepositoryType {
    func fetchCatalog(searchText: String) async throws -> [ExerciseCatalogItemDTO]
    func fetchDetail(slug: String) async throws -> ExerciseDetailDTO
}

final class ExerciseRepository: ExerciseRepositoryType {
    private let client: SupabaseClient?
    private let localDataSource: LocalExerciseLibraryDataSource

    init(
        client: SupabaseClient? = nil,
        localDataSource: LocalExerciseLibraryDataSource = .init()
    ) {
        if let client {
            self.client = client
        } else {
            self.client = try? SupabaseClientProvider.makeClient()
        }
        self.localDataSource = localDataSource
    }

    func fetchCatalog(searchText: String) async throws -> [ExerciseCatalogItemDTO] {
        if let remoteItems = try? await fetchCatalogFromRemote(searchText: searchText), !remoteItems.isEmpty {
            return remoteItems
        }
        return try localDataSource.fetchCatalog(searchText: searchText)
    }

    func fetchDetail(slug: String) async throws -> ExerciseDetailDTO {
        if let remoteDetail = try? await fetchDetailFromRemote(slug: slug) {
            return remoteDetail
        }
        return try localDataSource.fetchDetail(slug: slug)
    }

    private func fetchCatalogFromRemote(searchText: String) async throws -> [ExerciseCatalogItemDTO] {
        guard let client else {
            throw SupabaseConfigError.missingProjectConfiguration
        }

        let remote: [ExerciseCatalogItemDTO]
        do {
            remote = try await client
                .from("exercise_detail_v1")
                .select("id,slug,name,technique,primary_media_url,similar_names,muscles,equipment")
                .limit(1200)
                .execute()
                .value
        } catch {
            // Backward compatibility before applying migration that adds `technique`.
            remote = try await client
                .from("exercise_detail_v1")
                .select("id,slug,name,primary_media_url,similar_names,muscles,equipment")
                .limit(1200)
                .execute()
                .value
        }

        let query = normalized(searchText)
        guard !query.isEmpty else {
            return remote
        }

        return remote.filter { item in
            let text = [
                item.name,
                item.displayName,
                item.displayTechnique ?? "",
                item.slug,
                (item.similar_names ?? []).joined(separator: " "),
                item.muscles.map(\.name).joined(separator: " "),
                item.equipment.map(\.name).joined(separator: " ")
            ]
            .joined(separator: " ")
            return normalized(text).contains(query)
        }
    }

    private func fetchDetailFromRemote(slug: String) async throws -> ExerciseDetailDTO {
        guard let client else {
            throw SupabaseConfigError.missingProjectConfiguration
        }

        let response: [ExerciseDetailDTO] = try await client
            .from("exercise_detail_v1")
            .select()
            .eq("slug", value: slug)
            .limit(1)
            .execute()
            .value

        guard let detail = response.first else {
            throw ExerciseRepositoryError.notFound(slug)
        }
        return detail
    }

    private func normalized(_ value: String) -> String {
        value
            .folding(options: [.caseInsensitive, .diacriticInsensitive], locale: .current)
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// MARK: View Models
@MainActor
final class ExerciseDetailViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case loaded(ExerciseDetailDTO)
        case failed(String)
    }

    @Published private(set) var state: State = .idle

    private let repository: ExerciseRepositoryType
    private let slug: String

    init(slug: String, repository: ExerciseRepositoryType = ExerciseRepository()) {
        self.slug = slug
        self.repository = repository
    }

    func load() {
        state = .loading
        Task {
            do {
                let detail = try await repository.fetchDetail(slug: slug)
                state = .loaded(detail)
            } catch {
                state = .failed(error.localizedDescription)
            }
        }
    }
}

@MainActor
final class ExerciseCatalogViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case loaded([ExerciseCatalogItemDTO])
        case failed(String)
    }

    @Published private(set) var state: State = .idle
    @Published var searchText: String = "" {
        didSet { scheduleSearch() }
    }

    var resultsCount: Int {
        if case .loaded(let items) = state {
            return items.count
        }
        return 0
    }

    private let repository: ExerciseRepositoryType
    private var hasLoadedAtLeastOnce = false
    private var searchTask: Task<Void, Never>?

    init(repository: ExerciseRepositoryType = ExerciseRepository()) {
        self.repository = repository
    }

    func loadIfNeeded() {
        guard !hasLoadedAtLeastOnce else { return }
        hasLoadedAtLeastOnce = true
        search(debounced: false)
    }

    func retry() {
        search(debounced: false)
    }

    deinit {
        searchTask?.cancel()
    }

    private func scheduleSearch() {
        guard hasLoadedAtLeastOnce else { return }
        search(debounced: true)
    }

    private func search(debounced: Bool) {
        searchTask?.cancel()
        searchTask = Task { [weak self] in
            guard let self else { return }

            if debounced {
                try? await Task.sleep(nanoseconds: 260_000_000)
                if Task.isCancelled { return }
            }

            await performSearch(showLoading: !debounced)
        }
    }

    private func performSearch(showLoading: Bool) async {
        if showLoading {
            state = .loading
        }

        do {
            let items = try await repository.fetchCatalog(searchText: searchText)
            if Task.isCancelled { return }
            state = .loaded(items)
        } catch {
            if Task.isCancelled { return }
            state = .failed(error.localizedDescription)
        }
    }
}
