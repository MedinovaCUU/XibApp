import SwiftUI

struct NutritionShoppingListView: View {
    @StateObject private var viewModel: NutritionShoppingListViewModel

    init(recipes: [NutritionRecipe]) {
        _viewModel = StateObject(
            wrappedValue: NutritionShoppingListViewModel(recipes: recipes)
        )
    }

    var body: some View {
        ZStack {
            ObsidianBackground()
                .ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    headerCard

                    if viewModel.ingredientCount == 0 {
                        emptyStateCard
                    } else {
                        groupingPicker

                        ForEach(viewModel.groups) { group in
                            groupCard(group)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 40)
            }
            .scrollBounceBehavior(.basedOnSize)
        }
        .safeAreaPadding(.bottom, 8)
        .navigationTitle("Lista de súper")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var headerCard: some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 8) {
                Text("Lista de compras")
                    .font(AppFont.oxaniumBold(20))
                    .foregroundStyle(.white)

                Text("Generada con \(viewModel.recipeCount) platillo(s) seleccionado(s).")
                    .font(AppFont.oxaniumRegular(13))
                    .foregroundStyle(.white.opacity(0.82))

                Text("Marcados: \(viewModel.checkedCount) / \(viewModel.ingredientCount) artículos")
                    .font(AppFont.oxaniumBold(13))
                    .foregroundStyle(Brand.jadeGlow)
            }
        }
    }

    private var groupingPicker: some View {
        ObsidianGlassCard(content: {
            VStack(alignment: .leading, spacing: 10) {
                Text("Agrupar por")
                    .font(AppFont.oxaniumBold(15))
                    .foregroundStyle(.white)

                Picker("Agrupar por", selection: $viewModel.grouping) {
                    ForEach(ShoppingListGrouping.allCases) { grouping in
                        Text(grouping.rawValue).tag(grouping)
                    }
                }
                .pickerStyle(.segmented)
            }
        }, cornerRadius: 24)
    }

    private func groupCard(_ group: ShoppingListGroup) -> some View {
        ObsidianGlassCard(content: {
            VStack(alignment: .leading, spacing: 10) {
                Label(group.title, systemImage: group.icon)
                    .font(AppFont.oxaniumBold(16))
                    .foregroundStyle(.white)

                ForEach(Array(group.entries.enumerated()), id: \.element.id) { index, entry in
                    Button {
                        viewModel.toggle(entry)
                    } label: {
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: viewModel.isChecked(entry) ? "checkmark.circle.fill" : "circle")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundStyle(viewModel.isChecked(entry) ? Brand.jadeGlow : .white.opacity(0.82))
                                .padding(.top, 2)

                            VStack(alignment: .leading, spacing: 3) {
                                Text(entry.title)
                                    .font(AppFont.oxaniumRegular(14))
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                if let subtitle = entry.subtitle {
                                    Text(subtitle)
                                        .font(AppFont.oxaniumRegular(11))
                                        .foregroundStyle(.white.opacity(0.72))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(Color.white.opacity(viewModel.isChecked(entry) ? 0.12 : 0.06))
                        )
                    }
                    .buttonStyle(.plain)

                    if index < group.entries.count - 1 {
                        Divider()
                            .overlay(Color.white.opacity(0.12))
                    }
                }
            }
        }, cornerRadius: 24)
    }

    private var emptyStateCard: some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 10) {
                Text("No hay ingredientes para mostrar")
                    .font(AppFont.oxaniumBold(17))
                    .foregroundStyle(.white)

                Text("Selecciona al menos un platillo para generar tu lista de súper.")
                    .font(AppFont.oxaniumRegular(13))
                    .foregroundStyle(.white.opacity(0.82))
            }
        }
    }
}

#Preview {
    NavigationStack {
        NutritionShoppingListView(recipes: [])
    }
    .environment(\.locale, Locale(identifier: "es"))
}
