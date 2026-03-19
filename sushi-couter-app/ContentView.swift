import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \SushiItem.createdAt, order: .reverse) private var items: [SushiItem]
    
    private let haptic = UIImpactFeedbackGenerator(style: .medium)
    private let notificationHaptic = UINotificationFeedbackGenerator()
    
    @State private var showingAddSheet = false
    @State private var itemToDelete: SushiItem?
    @AppStorage("totalDeletionsCount") private var totalDeletionsCount = 0
    
    private var funnyDeleteMessages: [String] {
        AppConstants.Messages.funnyDeletions
    }
    
    private var currentFunnyMessage: String {
        if funnyDeleteMessages.isEmpty { return "" }
        let index = totalDeletionsCount % funnyDeleteMessages.count
        return funnyDeleteMessages[index]
    }
    
    var totalConsumido: Int {
        items.reduce(0) { $0 + $1.quantidade }
    }
    
    var body: some View {
        ZStack {
            // Fundo Sólido Suave (Doodle Style)
            Color(hex: AppConstants.Colors.background).ignoresSafeArea()
            
            // Padrão de bolinhas sutil ao fundo
            Canvas { context, size in
                let spacing = AppConstants.Design.dotPatternSpacing
                let dotSize = AppConstants.Design.dotPatternSize
                let opacity = AppConstants.Design.dotPatternOpacity
                
                for x in stride(from: 0, through: size.width, by: spacing) {
                    for y in stride(from: 0, through: size.height, by: spacing) {
                        context.fill(Path(ellipseIn: CGRect(x: x, y: y, width: dotSize, height: dotSize)), with: .color(Color.black.opacity(opacity)))
                    }
                }
            }
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header Doodle
                VStack(spacing: 4) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(AppConstants.Messages.appTitle)
                                .font(.system(.title, design: .rounded))
                                .fontWeight(.black)
                                .foregroundColor(.black)
                            
                            Text(Date.now.formatted(.dateTime.weekday(.wide).day().month(.wide)))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 12) {
                            Button(action: resetAll) {
                                Image(systemName: AppConstants.Icons.refresh)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .padding(10)
                                    .background(
                                        Circle()
                                            .fill(Color.white)
                                            .overlay(Circle().stroke(Color.black, lineWidth: AppConstants.Design.headerLineWidth))
                                            .shadow(color: .black.opacity(0.1), radius: 0, x: AppConstants.Design.headerShadowOffset, y: AppConstants.Design.headerShadowOffset)
                                    )
                            }
                            
                            Button(action: { showingAddSheet = true }) {
                                Image(systemName: AppConstants.Icons.add)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(
                                        Circle()
                                            .fill(Color.black)
                                            .shadow(color: .black.opacity(0.1), radius: 0, x: AppConstants.Design.headerShadowOffset, y: AppConstants.Design.headerShadowOffset)
                                    )
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    
                    // Total Hero Card
                    VStack(spacing: 4) {
                        Text(AppConstants.Messages.totalConsumedLabel)
                            .font(.system(.caption, design: .rounded))
                            .fontWeight(.black)
                            .foregroundColor(.secondary)
                            .tracking(AppConstants.Design.trackingWide)
                        
                        Text("\(totalConsumido)")
                            .font(.system(size: AppConstants.Design.heroNumberSize, weight: .black, design: .rounded))
                            .foregroundColor(.black)
                            .contentTransition(.numericText())
                            .overlay(
                                Text("\(totalConsumido)")
                                    .font(.system(size: AppConstants.Design.heroNumberSize, weight: .black, design: .rounded))
                                    .offset(x: 3, y: 3)
                                    .foregroundColor(.black.opacity(0.1))
                                    .zIndex(-1)
                            )
                    }
                    .padding(.vertical, 20)
                }
                
                // Lista de Itens
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
            
            // Custom Delete Modal Overlay
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
                            modelContext.delete(item)
                            try? modelContext.save()
                            itemToDelete = nil
                            notificationHaptic.notificationOccurred(.warning)
                        }
                    }
                )
                .zIndex(100)
            }
        }
        .sheet(isPresented: $showingAddSheet) {
            AddSushiView()
                .presentationDetents([.medium, .large])
                .presentationBackground(Color(hex: AppConstants.Colors.background))
        }
        .navigationBarHidden(true)
        .onAppear {
            seedInitialData()
        }
    }
    
    // MARK: - Actions
    
    private func incrementar(_ item: SushiItem) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            item.quantidade += 1
            try? modelContext.save()
            haptic.impactOccurred()
        }
    }
    
    private func decrementar(_ item: SushiItem) {
        if item.quantidade > 0 {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                item.quantidade -= 1
                try? modelContext.save()
                haptic.impactOccurred(intensity: 0.7)
            }
        }
    }
    
    private func resetAll() {
        withAnimation(.spring()) {
            // Limpa o banco de dados completamente de forma robusta
            try? modelContext.delete(model: SushiItem.self)
            try? modelContext.save()
            
            // Reseta o marcador de seed para forçar novo seed
            UserDefaults.standard.set(false, forKey: "hasPerformedInitialSeed")
            
            // Dispara o seed explicitamente
            seedInitialData()
            
            notificationHaptic.notificationOccurred(.success)
        }
    }
    
    private func seedInitialData() {
        // Usa UserDefaults para garantir que o seed ocorra apenas uma vez (ou após reset)
        let hasPerformedSeed = UserDefaults.standard.bool(forKey: "hasPerformedInitialSeed")
        
        if !hasPerformedSeed {
            // Limpa qualquer dado residual garantindo estado limpo
            try? modelContext.delete(model: SushiItem.self)
            
            let initialItems = [
                SushiItem(nome: "Harumaki", icon: "harumaki", color: AppConstants.Colors.harumaki),
                SushiItem(nome: "Hossomaki", icon: "hossomaki", color: AppConstants.Colors.hossomaki),
                SushiItem(nome: "Hot", icon: "hot", color: AppConstants.Colors.hot),
                SushiItem(nome: "Joe", icon: "joe", color: AppConstants.Colors.joe),
                SushiItem(nome: "Nigiri", icon: "nigiri", color: AppConstants.Colors.nigiri),
                SushiItem(nome: "Sashimi", icon: "sashimi", color: AppConstants.Colors.sashimi),
                SushiItem(nome: "Tiradito", icon: "tiradito", color: AppConstants.Colors.tiradito),
                SushiItem(nome: "Uramaki", icon: "uramaki", color: AppConstants.Colors.uramaki)
            ]
            
            for item in initialItems {
                modelContext.insert(item)
            }
            
            do {
                try modelContext.save()
                UserDefaults.standard.set(true, forKey: "hasPerformedInitialSeed")
            } catch {
                print("Erro ao salvar seed: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: SushiItem.self, inMemory: true)
}
