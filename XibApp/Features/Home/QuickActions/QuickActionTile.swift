import SwiftUI

struct QuickActionTile: View {
    let action: HomeQuickAction

    var body: some View {
        NavigationLink(value: action) {
            VStack(spacing: 8) {
                RoundedRectangle(cornerRadius: ShapeTokens.panelCorner, style: .continuous)
                    .fill(Brand.jadeGlow.opacity(0.22))
                    .frame(height: 44)
                    .overlay(
                        Image(systemName: action.icon)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.white)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: ShapeTokens.panelCorner, style: .continuous)
                            .stroke(Brand.borderLight, lineWidth: 0.8)
                    )
                    .shadow(color: Color.black.opacity(0.28), radius: 4, y: 2)

                Text(action.title)
                    .font(AppFont.oxaniumRegular(12))
                    .foregroundStyle(.white.opacity(0.92))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity, minHeight: ShapeTokens.tileMinHeight, alignment: .top)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
#Preview {
    ZStack {
        ObsidianBackground().ignoresSafeArea()
        HStack(spacing: 12) {
            ForEach(HomeQuickAction.allCases, id: \.self) { action in
                QuickActionTile(action: action)
            }
        }
        .padding()
    }
    .preferredColorScheme(.dark)
}
