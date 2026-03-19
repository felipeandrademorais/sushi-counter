import SwiftUI
import SwiftData

struct SushiRowView: View {
    @Environment(\.modelContext) private var modelContext
    let item: SushiItem
    let onIncrement: () -> Void
    let onDecrement: () -> Void
    let onDeleteRequest: (SushiItem) -> Void
    
    // Contador de exclusões persistente
    @AppStorage("totalDeletionsCount") private var totalDeletionsCount = 0
    
    var body: some View {
        HStack(spacing: 16) {
            // Icone com Glassmorphism Background
            ZStack {
                Circle()
                    .fill(Color(hex: item.color).opacity(0.15))
                    .frame(width: 64, height: 64)
                    .overlay(
                        Circle()
                            .stroke(Color(hex: item.color).opacity(0.8), lineWidth: 2)
                    )
                
                Image(item.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 46, height: 46)
                    .shadow(color: .black.opacity(0.1), radius: 1, x: 1, y: 1)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.nome)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text("Peças consumidas")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Controles interativos
            HStack(spacing: 12) {
                Button(action: onDecrement) {
                    Image(systemName: "minus")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .padding(10)
                        .background(
                            Circle()
                                .fill(item.quantidade > 0 ? Color.black.opacity(0.8) : Color.gray.opacity(0.3))
                                .overlay(
                                    Circle()
                                        .stroke(Color.black, lineWidth: 1)
                                )
                        )
                }
                .disabled(item.quantidade == 0)
                .scaleEffect(item.quantidade == 0 ? 0.9 : 1.0)
                
                Text("\(item.quantidade)")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.black)
                    .frame(width: 34)
                    .contentTransition(.numericText())
                
                Button(action: onIncrement) {
                    Image(systemName: "plus")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .padding(10)
                        .background(
                            Circle()
                                .fill(Color(hex: item.color))
                                .overlay(
                                    Circle()
                                        .stroke(Color.black, lineWidth: 1.5)
                                )
                                .shadow(color: Color.black.opacity(0.1), radius: 0, x: 2, y: 2)
                        )
                }
            }
            .buttonStyle(.plain)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(UIColor.secondarySystemGroupedBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(Color.primary.opacity(0.15), lineWidth: 2)
                )
                .shadow(color: Color.black.opacity(0.08), radius: 0, x: 4, y: 4)
        )
        .overlay(alignment: .topLeading) {
            Button(action: {
                onDeleteRequest(item)
            }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.red)
                    .background(Circle().fill(Color.white))
                    .shadow(radius: 2)
            }
            .offset(x: 6, y: -6)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.1).ignoresSafeArea()
        SushiRowView(
            item: SushiItem(nome: "Sashimi", quantidade: 2, icon: "sashimi", color: "FF5E5E"),
            onIncrement: {},
            onDecrement: {},
            onDeleteRequest: { _ in }
        )
    }
}
