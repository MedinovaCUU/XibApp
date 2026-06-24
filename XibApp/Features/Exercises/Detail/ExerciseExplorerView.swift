import SwiftUI

struct ExerciseExplorerView: View {
    @StateObject private var viewModel = ExerciseCatalogViewModel()

    var body: some View {
        ZStack {
            ObsidianBackground().ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 14) {
                    headerCard
                    searchCard
                    resultCounter
                    content
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
        }
        .navigationTitle("Ejercicios")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: String.self) { slug in
            ExerciseDetailScreen(slug: slug)
        }
        .task { viewModel.loadIfNeeded() }
        .preferredColorScheme(.dark)
    }

    private var headerCard: some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 8) {
                Text("Explora tu biblioteca")
                    .font(AppFont.oxaniumBold(20))
                    .crystalTitle()

                Text("Busca por nombre, músculo o variante. Abre cualquier ejercicio para ver instrucciones y registrar tus series.")
                    .font(AppFont.oxaniumRegular(13))
                    .foregroundStyle(.white.opacity(0.84))
            }
        }
    }

    private var searchCard: some View {
        ObsidianGlassCard {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.white.opacity(0.9))

                TextField("Buscar ejercicio o músculo", text: $viewModel.searchText)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .font(AppFont.oxaniumRegular(14))
                    .foregroundStyle(.white)

                if !viewModel.searchText.isEmpty {
                    Button {
                        viewModel.searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.white.opacity(0.72))
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 6)
        }
    }

    @ViewBuilder
    private var resultCounter: some View {
        switch viewModel.state {
        case .loaded(let items):
            Text("\(items.count) ejercicios disponibles")
                .font(AppFont.oxaniumRegular(12))
                .foregroundStyle(.white.opacity(0.75))
                .frame(maxWidth: .infinity, alignment: .leading)
        case .loading:
            Text("Buscando ejercicios...")
                .font(AppFont.oxaniumRegular(12))
                .foregroundStyle(.white.opacity(0.75))
                .frame(maxWidth: .infinity, alignment: .leading)
        case .idle, .failed:
            EmptyView()
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            loadingList
        case .failed(let message):
            ObsidianGlassCard {
                VStack(alignment: .leading, spacing: 10) {
                    Text("No se pudo cargar el catálogo")
                        .font(AppFont.oxaniumBold(16))
                        .foregroundStyle(.white)
                    Text(message)
                        .font(AppFont.oxaniumRegular(13))
                        .foregroundStyle(.white.opacity(0.82))

                    Button {
                        viewModel.retry()
                    } label: {
                        Text("Reintentar")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(GoldGlassButtonStyle(shape: .capsule, shineAngle: .degrees(30)))
                }
            }
        case .loaded(let items):
            if items.isEmpty {
                ObsidianGlassCard {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Sin coincidencias")
                            .font(AppFont.oxaniumBold(16))
                            .foregroundStyle(.white)
                        Text("Intenta con otro término, por ejemplo: sentadilla, espalda, triceps.")
                            .font(AppFont.oxaniumRegular(13))
                            .foregroundStyle(.white.opacity(0.82))
                    }
                }
            } else {
                LazyVStack(spacing: 10) {
                    ForEach(items) { item in
                        NavigationLink(value: item.slug) {
                            ExerciseCatalogRow(item: item)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }

    private var loadingList: some View {
        LazyVStack(spacing: 10) {
            ForEach(0..<8, id: \.self) { _ in
                ObsidianGlassCard {
                    VStack(alignment: .leading, spacing: 8) {
                        SkeletonText(width: .infinity, height: 20)
                        SkeletonText(width: .infinity, height: 14)
                        SkeletonChips(count: 3)
                    }
                }
            }
        }
    }
}

private struct ExerciseCatalogRow: View {
    let item: ExerciseCatalogItemDTO

    private var muscleNames: [String] {
        Array(item.muscles.map(\.name).prefix(3))
    }

    private var subtitleText: String {
        if let technique = item.displayTechnique, !technique.isEmpty {
            return technique
        }
        if let alt = item.similar_names?.first, !alt.isEmpty {
            return alt
        }
        return "Sin técnica específica"
    }

    private var subtitleColor: Color {
        item.displayTechnique == nil ? .white.opacity(0.56) : Brand.jadeGlow
    }

    var body: some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.displayName)
                            .font(AppFont.oxaniumBold(16))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)

                        Text(subtitleText)
                            .font(AppFont.oxaniumRegular(12))
                            .foregroundStyle(subtitleColor)
                    }

                    Spacer(minLength: 8)

                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.65))
                }

                if !muscleNames.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(muscleNames, id: \.self) { name in
                                BrandChip(text: name, style: .jade, shineAngle: .degrees(30))
                            }
                        }
                    }
                } else {
                    Text("Músculos: sin etiquetar")
                        .font(AppFont.oxaniumRegular(11))
                        .foregroundStyle(.white.opacity(0.56))
                }
            }
            .frame(maxWidth: .infinity, minHeight: ShapeTokens.rowMinHeight, alignment: .topLeading)
        }
    }
}

#Preview {
    NavigationStack {
        ExerciseExplorerView()
    }
    .preferredColorScheme(.dark)
}
