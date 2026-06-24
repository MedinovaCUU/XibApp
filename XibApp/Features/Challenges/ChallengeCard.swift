import SwiftUI

struct ChallengeCard: View {
    let challenge: Challenge
    var onTapCTA: (() -> Void)? = nil

    var body: some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 12) {
                ZStack(alignment: .topTrailing) {
                    AsyncImage(url: challenge.imageURL) { phase in
                        switch phase {
                        case .empty:
                            Color.gray.opacity(0.3)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                        case .failure:
                            Color.red.opacity(0.3)
                        @unknown default:
                            Color.gray.opacity(0.3)
                        }
                    }
                    .frame(height: 160)
                    .clipped()
                    .cornerRadius(12)

                    if challenge.isFeatured {
                        RibbonView()
                            .offset(x: 8, y: -8)
                    }
                }

                HStack(spacing: 8) {
                    Text(challenge.type.rawValue.uppercased())
                        .font(AppFont.oxaniumBold(11))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Brand.magentaCTA.opacity(0.15))
                        .foregroundStyle(Brand.magentaCTA)
                        .clipShape(Capsule())
                    Spacer()
                }

                Text(challenge.title)
                    .font(AppFont.oxaniumBold(18))
                    .foregroundStyle(.white)
                    .lineLimit(2)

                Text(challenge.subtitle)
                    .font(AppFont.oxaniumRegular(13))
                    .foregroundStyle(.white.opacity(0.85))
                    .lineLimit(2)

                ctaButton
            }
            .padding()
        }
    }

    @ViewBuilder
    private var ctaButton: some View {
        let title = challenge.ctaTitle ?? "Ver detalles"
        if let onTapCTA {
            Button(title, action: onTapCTA)
                .buttonStyle(GoldGlassButtonStyle())
                .frame(maxWidth: .infinity)
                .padding(.top, 6)
        } else {
            NavigationLink(value: challenge) {
                Text(title)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(GoldGlassButtonStyle())
            .padding(.top, 6)
        }
    }

    struct RibbonView: View {
        var body: some View {
            Text("FEATURED")
                .font(AppFont.oxaniumBold(11))
                .foregroundStyle(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Brand.magentaCTA)
                .clipShape(RibbonShape())
                .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
        }

        struct RibbonShape: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                let notch: CGFloat = 8
                path.move(to: CGPoint(x: rect.minX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.maxX - notch, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
                path.addLine(to: CGPoint(x: rect.maxX - notch, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
                path.closeSubpath()
                return path
            }
        }
    }
}

#Preview {
    ZStack {
        ObsidianBackground()
        ChallengeCard(challenge: .preview)
            .padding()
    }
    .preferredColorScheme(.dark)
}
