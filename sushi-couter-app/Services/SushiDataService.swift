import Foundation
import SwiftData

enum SushiDataService {

    private static let seedKey = "hasPerformedInitialSeed"

    // MARK: - CRUD

    static func incrementar(_ item: SushiItem, context: ModelContext) {
        item.quantidade += 1
        try? context.save()
    }

    static func decrementar(_ item: SushiItem, context: ModelContext) {
        guard item.quantidade > 0 else { return }
        item.quantidade -= 1
        try? context.save()
    }

    static func deleteItem(_ item: SushiItem, context: ModelContext) {
        context.delete(item)
        try? context.save()
    }

    static func addItem(nome: String, icon: String, color: String, context: ModelContext) {
        let newItem = SushiItem(nome: nome, icon: icon, color: color)
        context.insert(newItem)
        try? context.save()
    }

    // MARK: - Seed & Reset

    static func seedInitialData(context: ModelContext) {
        let hasPerformedSeed = UserDefaults.standard.bool(forKey: seedKey)
        guard !hasPerformedSeed else { return }

        try? context.delete(model: SushiItem.self)

        let initialItems = [
            SushiItem(nome: "Harumaki",  icon: "harumaki",  color: AppConstants.Colors.harumaki),
            SushiItem(nome: "Hossomaki", icon: "hossomaki", color: AppConstants.Colors.hossomaki),
            SushiItem(nome: "Hot",       icon: "hot",       color: AppConstants.Colors.hot),
            SushiItem(nome: "Joe",       icon: "joe",       color: AppConstants.Colors.joe),
            SushiItem(nome: "Nigiri",    icon: "nigiri",    color: AppConstants.Colors.nigiri),
            SushiItem(nome: "Sashimi",   icon: "sashimi",   color: AppConstants.Colors.sashimi),
            SushiItem(nome: "Tiradito",  icon: "tiradito",  color: AppConstants.Colors.tiradito),
            SushiItem(nome: "Uramaki",   icon: "uramaki",   color: AppConstants.Colors.uramaki)
        ]

        for item in initialItems {
            context.insert(item)
        }

        do {
            try context.save()
            UserDefaults.standard.set(true, forKey: seedKey)
        } catch {
            print("Erro ao salvar seed: \(error)")
        }
    }

    static func resetAll(context: ModelContext) {
        try? context.delete(model: SushiItem.self)
        try? context.save()
        UserDefaults.standard.set(false, forKey: seedKey)
        seedInitialData(context: context)
    }
}
