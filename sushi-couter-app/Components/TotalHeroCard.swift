import SwiftUI

struct TotalHeroCard: View {
    let totalPecas: Int
    let totalCalorias: Int
    
    @State private var isPulsing = false

    private var textColor: Color {
        if totalPecas <= 10 {
            return .black
        } else if totalPecas <= 25 {
            return Color(hex: AppConstants.Colors.accentPrimary) // #FF8C32
        } else if totalPecas <= 35 {
            return Color(hex: AppConstants.Colors.destructive) // #FF3B30
        } else {
            return Color(hex: AppConstants.Colors.destructive) // #FF3B30
        }
    }
    
    private var isFireMode: Bool {
        totalPecas > 35
    }

    var body: some View {
        VStack(spacing: 4) {
            Text(AppConstants.Messages.totalConsumedLabel)
                .font(.system(.caption, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(.secondary)
                .tracking(AppConstants.Design.trackingWide)

            HStack(spacing: 12) {
                if isFireMode {
                    Image(systemName: "flame.fill")
                        .font(.system(size: 40))
                        .foregroundColor(textColor)
                        .transition(.scale.combined(with: .opacity))
                }
                
                Text("\(totalPecas)")
                    .font(.system(size: AppConstants.Design.heroNumberSize, weight: .black, design: .rounded))
                    .foregroundColor(textColor)
                    .contentTransition(.numericText())
                    .shadow(color: isFireMode ? textColor.opacity(0.6) : .clear, radius: isPulsing ? 15 : 5)
                    .scaleEffect(isFireMode && isPulsing ? 1.1 : 1.0)
                    .animation(isFireMode ? .easeInOut(duration: 0.8).repeatForever(autoreverses: true) : .default, value: isPulsing)
                    .overlay(
                        Text("\(totalPecas)")
                            .font(.system(size: AppConstants.Design.heroNumberSize, weight: .black, design: .rounded))
                            .offset(x: 3, y: 3)
                            .foregroundColor(textColor.opacity(0.1))
                            .zIndex(-1)
                    )
                
                if isFireMode {
                    Image(systemName: "flame.fill")
                        .font(.system(size: 40))
                        .foregroundColor(textColor)
                        .transition(.scale.combined(with: .opacity))
                }
            }
            .animation(.spring(), value: totalPecas)

            Text("\(totalCalorias) kcal")
                .font(.system(.caption, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(.secondary)
                .tracking(AppConstants.Design.trackingStandard)
        }
        .padding(.vertical, 20)
        .onAppear {
            isPulsing = true
        }
    }
}

#Preview {
    VStack {
        TotalHeroCard(totalPecas: 5, totalCalorias: 100)
        TotalHeroCard(totalPecas: 15, totalCalorias: 300)
        TotalHeroCard(totalPecas: 30, totalCalorias: 600)
        TotalHeroCard(totalPecas: 40, totalCalorias: 800)
    }
    .background(Color(hex: AppConstants.Colors.background))
}
