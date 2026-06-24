//
//  Typography.swift
//  XibApp
//
//  Created by Ricardo Montañez Miranda on 09/09/25.
//

import SwiftUI
import UIKit

enum AppColor {
    // Tonos de texto para fondos oscuros
    static let textPrimary   = Color.white                      // Títulos / cuerpo principal
    static let textSecondary = Color.white.opacity(0.78)        // Subtítulos / labels
    static let textTertiary  = Color.white.opacity(0.60)        // Apoyo / notas
    static let textDisabled  = Color.white.opacity(0.38)        // Deshabilitado / placeholder
}

enum Typography {
    static let title         : Font = AppFont.oxaniumBold(24)
    static let sectionHeader : Font = AppFont.oxaniumBold(13)
    static let chip          : Font = AppFont.oxaniumRegular(13)
    static let stepNumber    : Font = AppFont.oxaniumBold(14)
    static let stepBody      : Font = AppFont.body(15)
    static let muscleName    : Font = AppFont.oxaniumRegular(12)
}

enum AppFont {
    // Intenta usar la fuente; si no existe, cae a SF Rounded
    static func oxaniumBold(_ size: CGFloat) -> Font {
        if UIFont(name: "Oxanium-Bold", size: size) != nil {
            return .custom("Oxanium-Bold", size: size)
        } else {
            return .system(size: size, weight: .bold, design: .rounded)
        }
    }
    static func oxaniumRegular(_ size: CGFloat) -> Font {
        if UIFont(name: "Oxanium-Regular", size: size) != nil {
            return .custom("Oxanium-Regular", size: size)
        } else {
            return .system(size: size, weight: .semibold, design: .rounded)
        }
    }
    static func oxaniumLight(_ size: CGFloat) -> Font {
        if UIFont(name: "Oxanium-ExtraLight", size: size) != nil {
            return .custom("Oxanium-ExtraLight", size: size)
        } else {
            return .system(size: size, weight: .semibold, design: .rounded)
        }
    }
    static func body(_ size: CGFloat = 16, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .rounded)
    }
    static func button(_ size: CGFloat = 17) -> Font {
        .system(size: size, weight: .semibold, design: .rounded)
    }
}
//MARK: TextTone.swift
private struct TextToneModifier: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content.foregroundStyle(color)
    }
}

extension View {
    @inline(__always) func textPrimary()   -> some View { modifier(TextToneModifier(color: AppColor.textPrimary)) }
    @inline(__always) func textSecondary() -> some View { modifier(TextToneModifier(color: AppColor.textSecondary)) }
    @inline(__always) func textTertiary()  -> some View { modifier(TextToneModifier(color: AppColor.textTertiary)) }
    @inline(__always) func textDisabled()  -> some View { modifier(TextToneModifier(color: AppColor.textDisabled)) }
}
//MARK:COLOR+HEX.swift

extension Color {
    init(hex: String, alpha: Double = 1) {
        let hexStr = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hexStr).scanHexInt64(&int)

        let r, g, b: UInt64
        switch hexStr.count {
        case 3: (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default: (r, g, b) = (0, 0, 0)
        }

        self = Color(
            .sRGB,
            red:   Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: alpha
        )
    }
}


//MARK: BRAND
enum Brand {
    // Fondo obsidiana
    static let obsidianTop    = Color(hex: "#0B1212")
    static let obsidianBottom = Color(hex: "#111A1A")

    // Acentos elegantes (tu paleta refinada)
    static let jadeGlow   = Color(hex: "#4DC9C6")  // Jade de alto contraste para iconos/acento
    static let goldGlow   = Color(hex: "#A28B33")  // OroBase
    static let magentaCTA = Color(hex: "#7a0006")  // MagentaBase

    // Bordes/brillos sutiles
    static let borderLight = Color.white.opacity(0.18)
    static let borderDark  = Color.black.opacity(0.35)
    static let highlight   = Color.white.opacity(0.35)
    
    // 🎯 Oro (para chips y toques premium)
    static let goldLight = Color(hex: "#054455")  // reflejo claro
    static let goldMid   = Color(hex: "#04212c")  // cuerpo del oro
    static let goldDeep  = Color(hex: "#081818")  // sombras del oro

    // Fondo translúcido estándar para chips
    static let chipFill  = Color.white.opacity(0.06)
    static let chipRim   = Color.white.opacity(0.08)
}

enum ShapeTokens {
    static let cardCorner: CGFloat = 24
    static let mediaCorner: CGFloat = 24
    static let panelCorner: CGFloat = 14
    static let fieldCorner: CGFloat = 12
    static let rowMinHeight: CGFloat = 108
    static let compactRowMinHeight: CGFloat = 96
    static let optionRowMinHeight: CGFloat = 48
    static let tileMinHeight: CGFloat = 84
}
//MARK: CRYSYALSTYLES
struct GlassCard<Content: View>: View {
    var corner: CGFloat = ShapeTokens.cardCorner
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .padding(16)
            .background(
                ZStack {
                    // Blur real del sistema
                    RoundedRectangle(cornerRadius: corner, style: .continuous)
                        .fill(.thinMaterial) // un toque más fuerte que ultraThin

                    // Tono de cristal (levísimo)
                    RoundedRectangle(cornerRadius: corner, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [.white.opacity(0.10), .white.opacity(0.04)],
                                startPoint: .topLeading, endPoint: .bottomTrailing
                            )
                        )

                    // Highlight superior (brillo)
                    RoundedRectangle(cornerRadius: corner, style: .continuous)
                        .strokeBorder(
                            LinearGradient(
                                colors: [.white.opacity(0.28), .white.opacity(0.06)],
                                startPoint: .top, endPoint: .bottom
                            ),
                            lineWidth: 1
                        )
                        .blendMode(.screen)
                }
            )
            .overlay(
                // Doble borde: claro + sombra leve para canto de vidrio
                RoundedRectangle(cornerRadius: corner, style: .continuous)
                    .stroke(Brand.borderLight, lineWidth: 0.9)
                    .overlay(
                        RoundedRectangle(cornerRadius: corner, style: .continuous)
                            .stroke(Brand.borderDark, lineWidth: 0.6)
                            .blur(radius: 1)
                            .offset(y: 1)
                            .mask(RoundedRectangle(cornerRadius: corner).fill(.black))
                    )
            )
            .shadow(color: .black.opacity(0.55), radius: 24, y: 14) // flotar más
    }
}

// Efecto de título tallado/cristal
struct CrystalTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .overlay(
                content
                    .foregroundStyle(Brand.highlight)
                    .blur(radius: 1.2)
            )
    }
}
extension View { func crystalTitle() -> some View { modifier(CrystalTitle()) } }
//denominacion generica
//denominacion distintiva
//lista de verificacion por cotejo
