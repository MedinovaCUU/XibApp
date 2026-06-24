import Foundation
import Supabase

enum SupabaseConfigError: LocalizedError {
    case missingProjectConfiguration
    case invalidProjectURL(String)
    case missingAnonKey

    var errorDescription: String? {
        switch self {
        case .missingProjectConfiguration:
            return "Falta SUPABASE_PROJECT_ID o SUPABASE_URL en Info.plist."
        case .invalidProjectURL(let value):
            return "La URL de Supabase no es valida: \(value)"
        case .missingAnonKey:
            return "Falta SUPABASE_ANON_KEY en Info.plist."
        }
    }
}

struct SupabaseConfig {
    let projectID: String
    let url: URL
    let anonKey: String

    static func loadFromInfoPlist(bundle: Bundle = .main) throws -> SupabaseConfig {
        let projectID = (bundle.object(forInfoDictionaryKey: "SUPABASE_PROJECT_ID") as? String)?
            .trimmingCharacters(in: .whitespacesAndNewlines)

        let explicitURL = (bundle.object(forInfoDictionaryKey: "SUPABASE_URL") as? String)?
            .trimmingCharacters(in: .whitespacesAndNewlines)

        let resolvedURLString: String
        if let projectID, !projectID.isEmpty {
            resolvedURLString = "https://\(projectID).supabase.co"
        } else if let explicitURL, !explicitURL.isEmpty {
            resolvedURLString = explicitURL
        } else {
            throw SupabaseConfigError.missingProjectConfiguration
        }

        guard let url = URL(string: resolvedURLString) else {
            throw SupabaseConfigError.invalidProjectURL(resolvedURLString)
        }

        let anonKey = (bundle.object(forInfoDictionaryKey: "SUPABASE_ANON_KEY") as? String)?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let isPlaceholder = anonKey.uppercased().contains("REPLACE_WITH_SUPABASE_ANON_KEY")
        guard !anonKey.isEmpty, !isPlaceholder else {
            throw SupabaseConfigError.missingAnonKey
        }

        let finalProjectID: String
        if let projectID, !projectID.isEmpty {
            finalProjectID = projectID
        } else {
            finalProjectID = url.host?
                .replacingOccurrences(of: ".supabase.co", with: "") ?? "unknown"
        }

        return SupabaseConfig(projectID: finalProjectID, url: url, anonKey: anonKey)
    }
}

enum SupabaseClientProvider {
    static func makeClient() throws -> SupabaseClient {
        let config = try SupabaseConfig.loadFromInfoPlist()
        return SupabaseClient(supabaseURL: config.url, supabaseKey: config.anonKey)
    }
}
