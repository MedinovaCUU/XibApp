import SwiftUI

// Efecto shimmer reutilizable
struct Shimmer: ViewModifier {
    @State private var phase: CGFloat = -1
    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(stops: [
                    .init(color: .white.opacity(0.0), location: 0),
                    .init(color: .white.opacity(0.35), location: 0.5),
                    .init(color: .white.opacity(0.0), location: 1)
                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                .rotationEffect(.degrees(20))
                .offset(x: phase * 200)
                .blendMode(.plusLighter)
                .mask(content)
            )
            .onAppear {
                withAnimation(.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                    phase = 1
                }
            }
    }
}
extension View { func shimmer() -> some View { modifier(Shimmer()) } }

// ---------- Skeleton components ----------
struct SkeletonMedia: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.white.opacity(0.06))
            .frame(height: 220)
            .shimmer()
    }
}

struct SkeletonText: View {
    var width: CGFloat? = nil    // nil = ocupa todo (infinity)
    var height: CGFloat = 18
    var body: some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(.white.opacity(0.06))
            .frame(maxWidth: width ?? .infinity, minHeight: height, maxHeight: height)
            .shimmer()
    }
}

struct SkeletonChips: View {
    let count: Int
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<count, id: \.self) { _ in
                Capsule()
                    .fill(.white.opacity(0.06))
                    .frame(width: 80, height: 26)
                    .shimmer()
            }
        }
    }
}

struct SkeletonListLines: View {
    let lines: Int
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(0..<lines, id: \.self) { _ in
                SkeletonText(height: 14)
            }
        }
    }
}

struct SkeletonMuscleRow: View {
    var body: some View {
        HStack(spacing: 12) {
            ForEach(0..<4, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white.opacity(0.06))
                    .frame(width: 72, height: 72)
                    .shimmer()
            }
        }
    }
}
#Preview("Skeletons") {
    ZStack {
        ObsidianBackground().ignoresSafeArea()
        VStack(spacing: 16) {
            SkeletonMedia()
            SkeletonText(width: .infinity, height: 24)
            SkeletonChips(count: 3)
            SkeletonListLines(lines: 4)
            SkeletonMuscleRow()
            SkeletonChips(count: 2)
        }
        .padding()
    }
    .preferredColorScheme(.dark)
}
