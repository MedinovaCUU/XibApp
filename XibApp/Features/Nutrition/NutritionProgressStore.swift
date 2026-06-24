import Foundation

@MainActor
final class NutritionProgressStore: ObservableObject {
    @Published private(set) var completedIDsByDay: [String: Set<String>] = [:]
    @Published private(set) var favoriteRecipeIDs: Set<String> = []

    private let completedKey = "xibapp.nutrition.completed.v1"
    private let favoritesKey = "xibapp.nutrition.favorites.v1"

    private lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    init() {
        load()
    }

    func completedIDs(for date: Date) -> Set<String> {
        completedIDsByDay[dayKey(for: date)] ?? []
    }

    func isCompleted(recipeID: String, on date: Date) -> Bool {
        completedIDs(for: date).contains(recipeID)
    }

    func toggleCompleted(recipeID: String, on date: Date) {
        let key = dayKey(for: date)
        var ids = completedIDsByDay[key] ?? []
        if ids.contains(recipeID) {
            ids.remove(recipeID)
        } else {
            ids.insert(recipeID)
        }
        completedIDsByDay[key] = ids
        saveCompleted()
    }

    func isFavorite(recipeID: String) -> Bool {
        favoriteRecipeIDs.contains(recipeID)
    }

    func toggleFavorite(recipeID: String) {
        if favoriteRecipeIDs.contains(recipeID) {
            favoriteRecipeIDs.remove(recipeID)
        } else {
            favoriteRecipeIDs.insert(recipeID)
        }
        saveFavorites()
    }

    private func dayKey(for date: Date) -> String {
        dayFormatter.string(from: date)
    }

    private func load() {
        if let completedData = UserDefaults.standard.data(forKey: completedKey),
           let rawCompleted = try? JSONDecoder().decode([String: [String]].self, from: completedData) {
            completedIDsByDay = rawCompleted.mapValues(Set.init)
        }

        if let favoritesData = UserDefaults.standard.data(forKey: favoritesKey),
           let rawFavorites = try? JSONDecoder().decode([String].self, from: favoritesData) {
            favoriteRecipeIDs = Set(rawFavorites)
        }
    }

    private func saveCompleted() {
        let raw = completedIDsByDay.mapValues { Array($0).sorted() }
        if let data = try? JSONEncoder().encode(raw) {
            UserDefaults.standard.set(data, forKey: completedKey)
        }
    }

    private func saveFavorites() {
        let raw = Array(favoriteRecipeIDs).sorted()
        if let data = try? JSONEncoder().encode(raw) {
            UserDefaults.standard.set(data, forKey: favoritesKey)
        }
    }
}
