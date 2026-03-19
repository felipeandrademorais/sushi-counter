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

    static func deleteLog(_ log: DailyConsumptionLog, context: ModelContext) {
        context.delete(log)
        try? context.save()
    }

    static func addItem(
        nome: String,
        icon: String,
        color: String,
        calorias: Int,
        context: ModelContext
    ) {
        let newItem = SushiItem(nome: nome, icon: icon, color: color, calorias: calorias)
        context.insert(newItem)
        try? context.save()
    }

    // MARK: - Seed & Reset

    static func seedInitialData(context: ModelContext) {
        let hasPerformedSeed = UserDefaults.standard.bool(forKey: seedKey)
        guard !hasPerformedSeed else { return }

        // Verifica se já existem itens para evitar duplicidade ou conflitos
        let descriptor = FetchDescriptor<SushiItem>()
        if let count = try? context.fetchCount(descriptor), count > 0 {
            // Se já tem dados, apenas marcamos como "seed realizado" e saímos
            UserDefaults.standard.set(true, forKey: seedKey)
            return
        }

        let initialItems = [
            SushiItem(nome: "Harumaki",  icon: "harumaki",  color: AppConstants.Colors.harumaki,  calorias: 160),
            SushiItem(nome: "Hossomaki", icon: "hossomaki", color: AppConstants.Colors.hossomaki, calorias: 50),
            SushiItem(nome: "Hot",       icon: "hot",       color: AppConstants.Colors.hot,       calorias: 140),
            SushiItem(nome: "Joe",       icon: "joe",       color: AppConstants.Colors.joe,       calorias: 120),
            SushiItem(nome: "Nigiri",    icon: "nigiri",    color: AppConstants.Colors.nigiri,    calorias: 90),
            SushiItem(nome: "Sashimi",   icon: "sashimi",   color: AppConstants.Colors.sashimi,   calorias: 60),
            SushiItem(nome: "Tiradito",  icon: "tiradito",  color: AppConstants.Colors.tiradito,  calorias: 100),
            SushiItem(nome: "Uramaki",   icon: "uramaki",   color: AppConstants.Colors.uramaki,   calorias: 150)
        ]

        for item in initialItems {
            context.insert(item)
        }

        do {
            try context.save()
            UserDefaults.standard.set(true, forKey: seedKey)
        } catch {
            // Falha silenciosa ou log estruturado se necessário, mas não atualiza o UserDefaults
        }
    }

    static func resetAll(context: ModelContext) {
        // Deleção robusta item a item para evitar crashes de schema/relacionamentos em migrações
        let descriptor = FetchDescriptor<SushiItem>()
        if let allItems = try? context.fetch(descriptor) {
            for item in allItems {
                context.delete(item)
            }
        }
        
        try? context.save()
        UserDefaults.standard.set(false, forKey: seedKey)
        seedInitialData(context: context)
    }
    
    static func saveDailyConsumption(totalSushis: Int, totalCalorias: Int, context: ModelContext) {
        let log = DailyConsumptionLog(
            createdAt: .now,
            totalSushis: totalSushis,
            totalCalorias: totalCalorias
        )
        context.insert(log)
        try? context.save()
    }
}
