import Foundation
import SwiftData

@Model
final class SushiItem: Identifiable {
    @Attribute(.unique) var id: UUID
    var nome: String = ""
    var quantidade: Int = 0
    var icon: String = "nigiri"
    var color: String = "FFE960"
    /// Calorias por unidade/peça.
    var calorias: Int = 0
    var createdAt: Date = Date()
    
    init(nome: String, quantidade: Int = 0, icon: String, color: String, calorias: Int = 0) {
        self.id = UUID()
        self.nome = nome
        self.quantidade = quantidade
        self.icon = icon
        self.color = color
        self.calorias = calorias
        self.createdAt = Date()
    }
}
