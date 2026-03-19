import SwiftUI
import SwiftData

@main
struct sushi_couter_appApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [SushiItem.self, DailyConsumptionLog.self])
    }
}
