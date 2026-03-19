import SwiftUI

struct AppConstants {
    struct Colors {
        static let background = "F9F7F2"
        static let destructive = "FF3B30"
        static let primaryText = "000000"
        static let secondaryText = "666666"
        static let selectionBackground = "FFF9C4"
        static let disabled = "A0A0A0"
        static let accentPrimary = "FF8C32"
        
        // Cores dos itens padrão do Seed
        static let harumaki = "FF5E5E"
        static let hossomaki = "4E9F3D"
        static let hot = "FFB319"
        static let joe = "FF8C32"
        static let nigiri = "845EC2"
        static let sashimi = "D65DB1"
        static let tiradito = "4B4453"
        static let uramaki = "C34A36"
    }
    
    struct Icons {
        static let all = ["harumaki", "hossomaki", "hot", "joe", "nigiri", "sashimi", "tiradito", "uramaki"]
        static let refresh = "arrow.counterclockwise"
        static let add = "plus"
    }
    
    struct Design {
        static let lineWidth: CGFloat = 3
        static let headerLineWidth: CGFloat = 2
        static let cornerRadius: CGFloat = 16
        static let modalCornerRadius: CGFloat = 24
        static let shadowOffset: CGFloat = 4
        static let modalShadowOffset: CGFloat = 8
        static let headerShadowOffset: CGFloat = 2
        
        static let dotPatternSpacing: CGFloat = 40
        static let dotPatternSize: CGFloat = 2
        static let dotPatternOpacity: Double = 0.03
        
        static let heroNumberSize: CGFloat = 96
        static let trackingWide: CGFloat = 2
        static let trackingStandard: CGFloat = 1
    }
    
    struct Messages {
        static let funnyDeletions: [String] = [
            "Dando tchau para esse delicioso sushi...",
            "Um sushi a menos no mundo... que tragédia! 😭",
            "Você realmente vai fazer isso? O sushiman vai ficar triste! 👨‍🍳💔",
            "E lá se vai mais um... a dieta agradece, o estômago reclama! 🥗",
            "Serial Sushi Killer! Quantos mais você vai eliminar? 🔪🍣",
            "O peixe nadou tanto pra terminar assim? Excluído! 🐟🚫",
            "CHEGA! Você já excluiu sushis demais! O próximo vai virar sashimi de você! 🦈😤"
        ]
        
        static let appTitle = "Sushi Counter"
        static let totalConsumedLabel = "TOTAL CONSUMIDO"
        static let menuLabel = "Menu"
        static let footerLabel = "🍣 Doodle Style by Senior Coder"
        static let newSushiTitle = "Novo Sushi"
        static let sushiNamePlaceholder = "Ex: Nigiri de Salmão"
        static let sushiNameLabel = "NOME DO SUSHI"
        static let chooseIconLabel = "ESCOLHER ÍCONE"
        static let chooseColorLabel = "COR DE DESTAQUE"
        static let addSushiButtonLabel = "Adicionar Sushi"
    }
}

// Extensão de cor para facilitar o uso dos Hex
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
