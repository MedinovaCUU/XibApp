//
//  ObsidianGlass.swift
//  XibApp
//
//  Created by Ricardo Montañez Miranda on 18/09/25.
//

import SwiftUI

private let accent = Color(hex: "#4DC9C6")

/// Tarjeta obsidiana con soporte para Liquid Glass (iOS 18+) y fallback custom en iOS anteriores.
/// - `styleIsClear`: si `true`, usa estilo .clear (útil sobre media). Si `false`, .regular.
/// - `tint`: tinte opcional (tu marca). Si `nil`, deja el material del sistema tal cual.
/// - `useMaterialFallback`: en el fallback, activa/ desactiva .ultraThinMaterial bajo el degradado.
/// - `topColor` / `bottomColor`: colores del degradado del fallback.
struct ObsidianGlassCard<Content: View>: View {
    @ViewBuilder let content: () -> Content

    var cornerRadius: CGFloat = ShapeTokens.cardCorner
    var styleIsClear: Bool = false
    var tint: Color? = nil

    // Fallback (iOS < 18)
    var useMaterialFallback: Bool = true
    var topColor: Color = .black.opacity(0.88)
    var bottomColor: Color = .jadeDark.opacity(0.36)

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            content()
        }
        .padding(16)
        .modifier(_GlassBackground(
            cornerRadius: cornerRadius,
            styleIsClear: styleIsClear,
            tint: tint,
            useMaterialFallback: useMaterialFallback,
            topColor: topColor,
            bottomColor: bottomColor
        ))
    }
}

private struct _GlassBackground: ViewModifier {
    let cornerRadius: CGFloat
    let styleIsClear: Bool
    let tint: Color?
    let useMaterialFallback: Bool
    let topColor: Color
    let bottomColor: Color

    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            if styleIsClear {
                if let tint {
                    return AnyView(
                        content.glassEffect(
                            .clear.tint(tint),
                            in: .rect(cornerRadius: cornerRadius)
                        )
                    )
                } else {
                    return AnyView(
                        content.glassEffect(
                            .clear,
                            in: .rect(cornerRadius: cornerRadius)
                        )
                    )
                }
            } else {
                if let tint {
                    return AnyView(
                        content.glassEffect(
                            .regular.tint(tint),
                            in: .rect(cornerRadius: cornerRadius)
                        )
                    )
                } else {
                    return AnyView(
                        content.glassEffect(
                            .regular,
                            in: .rect(cornerRadius: cornerRadius)
                        )
                    )
                }
            }
        } else {
            // 🔁 Tu fallback obsidiana (gradiente + overlays) aquí tal cual

            // 🔁 Fallback obsidiana (tu estilo anterior)
            return AnyView(
                content
                    // Degradado base
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [topColor, bottomColor],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    )
                    // Material bajo el degradado (puede aclarar si detrás es claro)
                    .background(
                        Group {
                            if useMaterialFallback {
                                AnyView(
                                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                                        .fill(.ultraThinMaterial)
                                )
                            } else {
                                AnyView(EmptyView())
                            }
                        }
                    )
                    // Rim claro
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .strokeBorder(Color.white.opacity(0.06), lineWidth: 0.8)
                            .blendMode(.plusLighter)
                    )
                    // Ribete turquesa
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .stroke(
                                LinearGradient(
                                    colors: [accent.opacity(0.38), .clear, accent.opacity(0.22)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1.2
                            )
                            .blur(radius: 0.2)
                            .opacity(0.9)
                    )
                    // Sombra interna
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .stroke(
                                LinearGradient(
                                    colors: [Color.black.opacity(0.30), Color.clear],
                                    startPoint: .bottomTrailing,
                                    endPoint: .topLeading
                                ),
                                lineWidth: 8
                            )
                            .blur(radius: 6)
                            .mask(
                                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                                    .fill(.black)
                            )
                    )
                    // Highlight superior
                    .overlay(alignment: .topLeading) {
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .stroke(
                                LinearGradient(
                                    colors: [Color.white.opacity(0.22), Color.clear],
                                    startPoint: .topLeading,
                                    endPoint: .center
                                ),
                                lineWidth: 1
                            )
                            .blendMode(.screen)
                    }
                    .shadow(color: .black.opacity(0.45), radius: 24, x: 0, y: 18)
                    .shadow(color: Color(hex: "#4DC9C6").opacity(0.14), radius: 8, x: 0, y: 4)
            )
        }
    }
}


// Modifier por si quieres aplicar el estilo a otras vistas
extension View {
    func obsidianGlass(cornerRadius: CGFloat = ShapeTokens.cardCorner) -> some View {
        self
            .padding(16)
            .background( ObsidianGlassCard { EmptyView() }.cornerRadius(cornerRadius) )
    }
}
//MARK:OBSIDIAN BACKGROUND

struct ObsidianBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Brand.obsidianTop, Brand.obsidianBottom],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // Halos sutiles (bokeh suave)
            Circle()
                .fill(Brand.jadeGlow.opacity(0.14))
                .frame(width: 380, height: 380)
                .blur(radius: 80)
                .offset(x: -140, y: -200)

            Circle()
                .fill(Brand.goldGlow.opacity(0.12))
                .frame(width: 320, height: 320)
                .blur(radius: 90)
                .offset(x: 160, y: 120)

            // Grano leve para sensación de material
//            Rectangle()
//                .fill(.black.opacity(0.05))
//                .blendMode(.overlay)
//                .ignoresSafeArea()
        }
    }
}


// MARK: OBSIDIAN CHIP
struct ObsidianChip: View {
    let text: String
    /// Ángulo del brillo (24°–36° recomendado)
    var shineAngle: Angle = .degrees(30)

    var body: some View {
        let accent = Color(hex: "#4DC9C6")
        let lw: CGFloat = 1.2 // grosor del trazo iluminado

        return Text(text)
            .font(Typography.chip)
            .textPrimary()
            .padding(.horizontal, 12)
            .padding(.vertical, 7)
            .background(
                Capsule().fill(Color.white.opacity(0.06))
            )
            // Rim claro de vidrio
            .overlay(
                Capsule()
                    .stroke(Color.white.opacity(0.08), lineWidth: 0.8)
                    .blendMode(.plusLighter)
            )
            // ⭐ Brillo turquesa: gradiente rotado + máscara con el trazo del óvalo
            .overlay {
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: accent.opacity(0.55), location: 0.15),
                                .init(color: .clear,               location: 0.45),
                                .init(color: accent.opacity(0.28), location: 0.65),
                                .init(color: .clear,               location: 0.90)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .rotationEffect(shineAngle)
                    .mask( Capsule().stroke(lineWidth: lw) )
                    .compositingGroup()
            }
            .shadow(color: Color.black.opacity(0.35), radius: 6, x: 0, y: 2)
    }
}

enum ChipStyle {
    case jade
    case gold
    case neutral
}

/// Chip unificado con brillo angular correcto + variantes de marca
struct BrandChip: View {
    let text: String
    var style: ChipStyle = .jade
    /// Ángulo del brillo (24°–36° recomendado)
    var shineAngle: Angle = .degrees(30)

    var body: some View {
        let rimLine: CGFloat = 1.2

        return Text(text)
            .font(Typography.chip)
            .textPrimary()
            .padding(.horizontal, 12)
            .padding(.vertical, 7)
            .background(
                Capsule().fill(Brand.chipFill)
            )
            // Rim claro de vidrio
            .overlay(
                Capsule()
                    .stroke(Brand.chipRim, lineWidth: 0.8)
                    .blendMode(.plusLighter)
            )
            // ⭐ Brillo enmascarado con ángulo (no se deforma en óvalo)
            .overlay {
                Rectangle()
                    .fill(gradientForStyle(style))
                    .rotationEffect(shineAngle)
                    .mask( Capsule().stroke(lineWidth: rimLine) )
                    .compositingGroup()
            }
            .shadow(color: Color.black.opacity(0.35), radius: 6, x: 0, y: 2)
    }

    // Gradiente del “filo” según estilo
    private func gradientForStyle(_ style: ChipStyle) -> LinearGradient {
        switch style {
        case .jade:
            return LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Brand.jadeGlow.opacity(0.55), location: 0.15),
                    .init(color: Color.clear,                 location: 0.45),
                    .init(color: Brand.jadeGlow.opacity(0.28), location: 0.65),
                    .init(color: Color.clear,                 location: 0.90)
                ]),
                startPoint: .top, endPoint: .bottom
            )
        case .gold:
            // Mezcla cálida: reflejo claro → cuerpo oro → sombra oro
            return LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Brand.goldLight.opacity(0.62), location: 0.14),
                    .init(color: Color.clear,                   location: 0.40),
                    .init(color: Brand.goldMid.opacity(0.40),   location: 0.62),
                    .init(color: Brand.goldDeep.opacity(0.30),  location: 0.78),
                    .init(color: Color.clear,                   location: 0.92)
                ]),
                startPoint: .top, endPoint: .bottom
            )
        case .neutral:
            return LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color.white.opacity(0.45), location: 0.18),
                    .init(color: Color.clear,               location: 0.48),
                    .init(color: Color.white.opacity(0.20), location: 0.70),
                    .init(color: Color.clear,               location: 0.92)
                ]),
                startPoint: .top, endPoint: .bottom
            )
        }
    }
}

// Para cohesión visual: cápsula por defecto; si quieres esquinas 46, usa .corner(46)
enum PillShape {
    case capsule
    case corner(CGFloat)
}

struct GoldGlassButtonStyle: ButtonStyle {
    var shape: PillShape = .capsule
    var shineAngle: Angle = .degrees(30) // mismo ángulo que tus chips

    func makeBody(configuration: Configuration) -> some View {
        _GoldGlassButton(
            label: configuration.label,
            shape: shape,
            shineAngle: shineAngle,
            isPressed: configuration.isPressed
        )
    }

    // MARK: - Impl
    private struct _GoldGlassButton: View {
        let label: ButtonStyle.Configuration.Label
        let shape: PillShape
        let shineAngle: Angle
        let isPressed: Bool

        private var goldFill: LinearGradient {
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Brand.goldDeep,  location: 0.00),
                    .init(color: Brand.goldMid,   location: 0.30),
                    .init(color: Brand.goldLight, location: 0.58),
                    .init(color: Brand.goldMid,   location: 0.82),
                    .init(color: Brand.goldDeep,  location: 1.00),
                ]),
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
        }

        private var topGloss: LinearGradient {
            LinearGradient(
                colors: [
                    Color.white.opacity(0.16),
                    Color.white.opacity(0.04),
                    Color.clear
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }

        private var rimStroke: LinearGradient {
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color.white.opacity(0.26), location: 0.00),
                    .init(color: Color.white.opacity(0.08), location: 0.55),
                    .init(color: Color.black.opacity(0.24), location: 1.00),
                ]),
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
        }

        private var edgeTrace: LinearGradient {
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color.clear,                  location: 0.10),
                    .init(color: Brand.goldLight.opacity(0.52), location: 0.28),
                    .init(color: Color.clear,                  location: 0.48),
                    .init(color: Brand.goldMid.opacity(0.36),   location: 0.68),
                    .init(color: Color.clear,                  location: 0.88),
                ]),
                startPoint: .top, endPoint: .bottom
            )
        }

        var body: some View {
            let base = label
                .labelStyle(.titleAndIcon)
                .font(AppFont.oxaniumBold(14))
                .lineLimit(1)
                .minimumScaleFactor(0.82)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, minHeight: 20, alignment: .center)
                .padding(.horizontal, 16)
                .padding(.vertical, 11)
                .foregroundStyle(.white)

            switch shape {
            case .capsule:
                return AnyView(
                    base
                        .background(Capsule().fill(goldFill))
                        .background(Capsule().fill(.ultraThinMaterial).opacity(0.12))
                        .overlay(Capsule().fill(topGloss).blendMode(.screen))
                        .overlay(Capsule().stroke(rimStroke, lineWidth: 1.0))
                        .overlay(
                            Rectangle()
                                .fill(edgeTrace)
                                .rotationEffect(shineAngle)
                                .mask(Capsule().stroke(lineWidth: 1.1))
                        )
                        .shadow(color: .black.opacity(0.32), radius: 8, x: 0, y: 4)
                        .scaleEffect(isPressed ? 0.98 : 1.0)
                        .opacity(isPressed ? 0.95 : 1.0)
                        .animation(.easeOut(duration: 0.12), value: isPressed)
                )

            case .corner(let r):
                let rr = RoundedRectangle(cornerRadius: r, style: .continuous)
                return AnyView(
                    base
                        .background(rr.fill(goldFill))
                        .background(rr.fill(.ultraThinMaterial).opacity(0.12))
                        .overlay(rr.fill(topGloss).blendMode(.screen))
                        .overlay(rr.stroke(rimStroke, lineWidth: 1.0))
                        .overlay(
                            Rectangle()
                                .fill(edgeTrace)
                                .rotationEffect(shineAngle)
                                .mask(rr.stroke(lineWidth: 1.1))
                        )
                        .shadow(color: .black.opacity(0.32), radius: 8, x: 0, y: 4)
                        .scaleEffect(isPressed ? 0.98 : 1.0)
                        .opacity(isPressed ? 0.95 : 1.0)
                        .animation(.easeOut(duration: 0.12), value: isPressed)
                )
            }
        }

    }
}

struct MacroPill: View {
    let title: String
    let value: String
    var unit: String? = nil
    var icon: String? = nil
    var shape: PillShape = .capsule
    var action: () -> Void = {}   // ← valor por defecto

    var body: some View {
        Button(action: action) {
            VStack(spacing: 2) {
                Text(title.uppercased())
                    .font(AppFont.oxaniumRegular(10))
                    .foregroundStyle(.white.opacity(0.82))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)

                HStack(spacing: 4) {
                    if let icon {
                        Image(systemName: icon)
                            .imageScale(.small)
                            .foregroundStyle(.white.opacity(0.86))
                    }
                    Text(value + (unit.map { " \($0)" } ?? ""))
                        .font(AppFont.oxaniumBold(13))
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.82)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal, 4)
        }
        .buttonStyle(GoldGlassButtonStyle(shape: shape, shineAngle: .degrees(30)))
        .accessibilityAddTraits(.isButton)
    }
}
