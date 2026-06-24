import Foundation

@MainActor
final class ChallengesViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case loaded([XibApp.Challenge])
        case failed(String)
    }

    @Published private(set) var state: State = .idle
    @Published var selectedFilter: ChallengeFilter = .all

    private let repository: ChallengesRepositoryType

    init(repository: ChallengesRepositoryType = LocalChallengesRepository()) {
        self.repository = repository
    }

    func load() {
        state = .loading
        Task {
            do {
                let challenges = try await repository.fetchChallenges()
                state = .loaded(challenges)
            } catch {
                state = .failed(error.localizedDescription)
            }
        }
    }

    func loadIfNeeded() {
        if case .idle = state {
            load()
        }
    }

    var filteredChallenges: [XibApp.Challenge] {
        guard case let .loaded(challenges) = state else {
            return []
        }
        switch selectedFilter {
        case .all:
            return challenges
        case .promotions:
            return challenges.filter { $0.type == .promotion }
        case .events:
            return challenges.filter { $0.type == .event }
        case .active:
            let now = Date()
            return challenges.filter { $0.isActive(on: now) }
        }
    }
}

final class ChallengesListViewModel: ObservableObject {
    @Published var all: [XibApp.Challenge] = []
    @Published var filtered: [XibApp.Challenge] = []
    @Published var isLoading: Bool = false
    @Published var filter: ChallengeType? = nil { didSet { applyFilter() } }
    @Published var search: String = "" { didSet { applyFilter() } }

    let repository: ChallengesRepository

    init(repository: ChallengesRepository = .init()) {
        self.repository = repository
    }

    @MainActor
    func loadInitial() async {
        let cached = repository.loadCached()
        if cached.isEmpty {
            await refresh()
        } else {
            all = cached
            applyFilter()
        }
    }

    @MainActor
    func refresh() async {
        isLoading = true
        let newItems = await repository.refresh()
        all = newItems
        applyFilter()
        isLoading = false
    }

    func applyFilter() {
        let filteredByType: [XibApp.Challenge]
        if let filter {
            filteredByType = all.filter { $0.type == filter }
        } else {
            filteredByType = all
        }

        let query = search.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if query.isEmpty {
            filtered = filteredByType
            return
        }

        filtered = filteredByType.filter {
            $0.title.lowercased().contains(query) || $0.subtitle.lowercased().contains(query)
        }
    }

    func add(_ challenge: XibApp.Challenge) {
        all.insert(challenge, at: 0)
        repository.saveCache(all)
        applyFilter()
    }

    func remove(at offsets: IndexSet) {
        all.remove(atOffsets: offsets)
        repository.saveCache(all)
        applyFilter()
    }

    func move(from source: IndexSet, to destination: Int) {
        all.move(fromOffsets: source, toOffset: destination)
        repository.saveCache(all)
        applyFilter()
    }
}
