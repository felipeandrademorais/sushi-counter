import Foundation
import SwiftData

@Model
final class DailyConsumptionLog: Identifiable {
    @Attribute(.unique) var id: UUID
    var createdAt: Date
    var totalSushis: Int
    var totalCalorias: Int

    init(createdAt: Date = .now, totalSushis: Int, totalCalorias: Int) {
        self.id = UUID()
        self.createdAt = createdAt
        self.totalSushis = totalSushis
        self.totalCalorias = totalCalorias
    }
}
