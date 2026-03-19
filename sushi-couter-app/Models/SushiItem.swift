import Foundation
import SwiftData

@Model
final class SushiItem: Identifiable {
    @Attribute(.unique) var id: UUID
    var nome: String
    var quantidade: Int
    var icon: String
    var color: String
    var createdAt: Date = Date()
    
    init(nome: String, quantidade: Int = 0, icon: String, color: String) {
        self.id = UUID()
        self.nome = nome
        self.quantidade = quantidade
        self.icon = icon
        self.color = color
        self.createdAt = Date()
    }
}
