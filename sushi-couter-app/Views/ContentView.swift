import SwiftUI
import SwiftData

// MARK: - Active Sheet Enum

enum ActiveSheet: Identifiable {
    case addSushi
    case history
    case share

    var id: Int { hashValue }
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \SushiItem.createdAt, order: .reverse) private var items: [SushiItem]

    @State private var activeSheet: ActiveSheet?
    @State private var itemToDelete: SushiItem?
    @State private var showSaveSuccessAlert = false
    @AppStorage("totalDeletionsCount") private var totalDeletionsCount = 0

    private let haptic = UIImpactFeedbackGenerator(style: .medium)
    private let notificationHaptic = UINotificationFeedbackGenerator()

    private var currentFunnyMessage: String {
        let messages = AppConstants.Messages.funnyDeletions
        guard !messages.isEmpty else { return "" }
        return messages[totalDeletionsCount % messages.count]
    }

    private var totalConsumido: Int {
        items.reduce(0) { $0 + $1.quantidade }
    }
    
    private var totalCalorias: Int {
        items.reduce(0) { partialResult, item in
            partialResult + (item.quantidade * item.calorias)
        }
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            Color(hex: AppConstants.Colors.background).ignoresSafeArea()
            DotPatternBackground()

            VStack(spacing: 10) {
                headerSection
                TotalHeroCard(totalPecas: totalConsumido, totalCalorias: totalCalorias)
                menuList
            }

            deleteModalOverlay

            // Save success modal
            if showSaveSuccessAlert {
                CustomAlertModal(
                    title: AppConstants.Messages.saveConsumptionSuccessTitle,
                    message: AppConstants.Messages.saveConsumptionSuccessMessage,
                    buttonLabel: AppConstants.Messages.okButton,
                    onDismiss: {
                        withAnimation(.spring()) {
                            showSaveSuccessAlert = false
                        }
                    }
                )
                .zIndex(100)
            }
        }
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .addSushi:
                AddSushiView()
                    .presentationDetents([.height(570), .large])
                    .presentationBackground(Color(hex: AppConstants.Colors.background))
            case .history:
                HistoryView()
                    .presentationDetents([.height(570), .large])
                    .presentationBackground(Color(hex: AppConstants.Colors.background))
            case .share:
                ShareSheetView(totalPecas: totalConsumido, totalCalorias: totalCalorias)
                    .presentationDetents([.large])
                    .presentationBackground(Color(hex: AppConstants.Colors.background))
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            SushiDataService.seedInitialData(context: modelContext)
        }
    }

    // MARK: - Subviews

    private var headerSection: some View {
        HeaderView(
            canSave: totalConsumido > 0,
            onReset: resetAll,
            onHistory: { activeSheet = .history },
            onSave: saveDailyConsumption,
            onShare: { activeSheet = .share },
            onAdd: { activeSheet = .addSushi }
        )
    }

    private var menuList: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                ForEach(items) { item in
                    SushiRowView(
                        item: item,
                        canIncrement: canIncrement(item),
                        onIncrement: { incrementar(item) },
                        onDecrement: { decrementar(item) },
                        onDeleteRequest: { item in
                            withAnimation(.spring()) {
                                itemToDelete = item
                            }
                        }
                    )
                }
            }
            .padding(.top, 8)
        }
    }

    @ViewBuilder
    private var deleteModalOverlay: some View {
        if let item = itemToDelete {
            CustomDeleteModal(
                item: item,
                message: currentFunnyMessage,
                onCancel: {
                    withAnimation(.spring()) {
                        itemToDelete = nil
                    }
                },
                onDelete: {
                    withAnimation(.spring()) {
                        totalDeletionsCount += 1
                        SushiDataService.deleteItem(item, context: modelContext)
                        itemToDelete = nil
                        notificationHaptic.notificationOccurred(.warning)
                    }
                }
            )
            .zIndex(100)
        }
    }

    // MARK: - Actions

    private func canIncrement(_ item: SushiItem) -> Bool {
        item.quantidade < AppConstants.Limits.maxPerItem &&
        totalConsumido < AppConstants.Limits.maxTotalConsumed
    }

    private func incrementar(_ item: SushiItem) {
        guard canIncrement(item) else { return }
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            SushiDataService.incrementar(item, context: modelContext)
            haptic.impactOccurred()
        }
    }

    private func decrementar(_ item: SushiItem) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            SushiDataService.decrementar(item, context: modelContext)
            haptic.impactOccurred(intensity: 0.7)
        }
    }

    private func resetAll() {
        withAnimation(.spring()) {
            SushiDataService.resetAll(context: modelContext)
            notificationHaptic.notificationOccurred(.success)
        }
    }
    
    private func saveDailyConsumption() {
        SushiDataService.saveDailyConsumption(
            totalSushis: totalConsumido,
            totalCalorias: totalCalorias,
            context: modelContext
        )
        showSaveSuccessAlert = true
        notificationHaptic.notificationOccurred(.success)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [SushiItem.self, DailyConsumptionLog.self], inMemory: true)
}
