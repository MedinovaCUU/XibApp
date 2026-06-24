import SwiftUI

struct QuickActionsSection: View {
    private let actions = HomeQuickAction.allCases

    var body: some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 12) {
                Text("Acciones rápidas")
                    .font(AppFont.oxaniumBold(16))
                    .crystalTitle()

                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 4),
                    spacing: 12
                ) {
                    ForEach(actions) { action in
                        QuickActionTile(action: action)
                    }
                }
            }
        }
    }
}
#Preview {
    NavigationStack {
        ZStack {
            ObsidianBackground().ignoresSafeArea()
            ScrollView { QuickActionsSection().padding() }
        }
    }
    .preferredColorScheme(.dark)
}

