import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \SushiItem.createdAt, order: .reverse) private var items: [SushiItem]

    @State private var showingAddSheet = false
    @State private var itemToDelete: SushiItem?
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

    // MARK: - Body

    var body: some View {
        ZStack {
            Color(hex: AppConstants.Colors.background).ignoresSafeArea()
            DotPatternBackground()

            VStack(spacing: 0) {
                headerSection
                TotalHeroCard(total: totalConsumido)
                menuList
            }

            deleteModalOverlay
        }
        .sheet(isPresented: $showingAddSheet) {
            AddSushiView()
                .presentationDetents([.medium, .large])
                .presentationBackground(Color(hex: AppConstants.Colors.background))
        }
        .navigationBarHidden(true)
        .onAppear {
            SushiDataService.seedInitialData(context: modelContext)
        }
    }

    // MARK: - Subviews

    private var headerSection: some View {
        HeaderView(
            onReset: resetAll,
            onAdd: { showingAddSheet = true }
        )
    }

    private var menuList: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                HStack {
                    Text(AppConstants.Messages.menuLabel)
                        .font(.system(.headline, design: .rounded))
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal, 24)

                ForEach(items) { item in
                    SushiRowView(
                        item: item,
                        onIncrement: { incrementar(item) },
                        onDecrement: { decrementar(item) },
                        onDeleteRequest: { item in
                            withAnimation(.spring()) {
                                itemToDelete = item
                            }
                        }
                    )
                }

                Text(AppConstants.Messages.footerLabel)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary.opacity(0.4))
                    .padding(.top, 40)
                    .padding(.bottom, 40)
            }
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

    private func incrementar(_ item: SushiItem) {
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
}

#Preview {
    ContentView()
        .modelContainer(for: SushiItem.self, inMemory: true)
}
