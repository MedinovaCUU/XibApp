import SwiftUI

struct ContentView: View {
    var body: some View {
        ExerciseExplorerView()
    }
}
#Preview {
    NavigationStack {
        ContentView()
    }
        .environment(\.locale, Locale(identifier: "es"))
        .preferredColorScheme(.dark)
}
