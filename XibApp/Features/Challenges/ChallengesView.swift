import SwiftUI

struct ChallengesView: View {
    @StateObject private var vm: ChallengesListViewModel

    init(remoteURL: URL? = nil) {
        _vm = StateObject(wrappedValue: ChallengesListViewModel(repository: ChallengesRepository(remoteURL: remoteURL)))
    }

    var body: some View {
        ZStack {
            ObsidianBackground().ignoresSafeArea()
            ScrollView {
                VStack(spacing: 16) {
                    header
                    ChallengeFilterBar(selection: $vm.filter)
                    ChallengeSearchBar(text: $vm.search)
                    ChallengesListSection(items: vm.filtered)
                }
                .padding(16)
                .padding(.bottom, 28)
            }
        }
        .navigationTitle("")
        .toolbar { addToolbar }
        .task { await vm.loadInitial() }
        .refreshable { await vm.refresh() }
        .navigationDestination(for: Challenge.self) { challenge in
            ChallengeDetailView(challenge: challenge)
        }
        .preferredColorScheme(.dark)
        .tint(Brand.magentaCTA)
    }

    private var header: some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 8) {
                Text("Challenges")
                    .font(AppFont.oxaniumBold(22))
                    .crystalTitle()
                Text("Promociones, eventos y retos especiales")
                    .font(AppFont.oxaniumRegular(14))
                    .foregroundStyle(.white.opacity(0.85))
            }
        }
    }

    @ToolbarContentBuilder
    private var addToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                let demo = Challenge.preview
                vm.add(demo)
            } label: {
                Image(systemName: "plus.circle.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Brand.magentaCTA, .white)
            }
            .accessibilityLabel("Agregar challenge")
        }
    }
}

struct ChallengeFilterBar: View {
    @Binding var selection: ChallengeType?

    var body: some View {
        ObsidianGlassCard {
            HStack(spacing: 8) {
                FilterChip(title: "Todos", isSelected: selection == nil) {
                    selection = nil
                }
                ForEach(ChallengeType.allCases) { t in
                    FilterChip(title: t.rawValue, isSelected: selection == t) {
                        selection = t
                    }
                }
            }
        }
    }
}

private struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppFont.oxaniumRegular(13))
                .foregroundStyle(isSelected ? .black : .white)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    Capsule().fill(isSelected ? AnyShapeStyle(Brand.magentaCTA) : AnyShapeStyle(.thinMaterial))
                )
                .overlay(
                    Capsule().stroke(Brand.borderLight, lineWidth: 0.9)
                )
        }
        .buttonStyle(.plain)
    }
}

struct ChallengeSearchBar: View {
    @Binding var text: String

    var body: some View {
        ObsidianGlassCard {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.white.opacity(0.9))
                TextField("Buscar…", text: $text)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .font(AppFont.oxaniumRegular(14))
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 6)
        }
    }
}

struct ChallengesListSection: View {
    let items: [Challenge]

    var body: some View {
        LazyVStack(spacing: 12) {
            ForEach(items, id: \.id) { c in
                ChallengeCard(challenge: c)
            }
        }
    }
}

#Preview {
    NavigationStack { ChallengesView() }
        .environment(\.locale, Locale(identifier: "es"))
        .preferredColorScheme(.dark)
        .tint(Brand.magentaCTA)
}
