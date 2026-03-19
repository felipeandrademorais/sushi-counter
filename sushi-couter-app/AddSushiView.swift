import SwiftUI
import SwiftData

struct AddSushiView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var nome: String = ""
    @State private var selectedIcon: String = "nigiri"
    @State private var selectedColor: String = AppConstants.Colors.harumaki
    
    let icons = AppConstants.Icons.all
    let colors = [
        AppConstants.Colors.harumaki,
        AppConstants.Colors.hossomaki,
        AppConstants.Colors.hot,
        AppConstants.Colors.joe,
        AppConstants.Colors.nigiri,
        AppConstants.Colors.sashimi,
        AppConstants.Colors.tiradito,
        AppConstants.Colors.uramaki
    ]
    
    private let haptic = UISelectionFeedbackGenerator()
    
    var body: some View {
        ZStack {
            Color(hex: AppConstants.Colors.background).ignoresSafeArea()
            
            VStack(spacing: 24) {
                // Header
                Text(AppConstants.Messages.newSushiTitle)
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.black)
                    .padding(.top, 24)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        // Nome do Sushi
                        VStack(alignment: .leading, spacing: 8) {
                            Text(AppConstants.Messages.sushiNameLabel)
                                .font(.system(.caption, design: .rounded))
                                .fontWeight(.black)
                                .foregroundColor(.secondary)
                                .tracking(AppConstants.Design.trackingStandard)
                            
                            TextField(AppConstants.Messages.sushiNamePlaceholder, text: $nome)
                                .font(.system(.body, design: .rounded))
                                .fontWeight(.bold)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: AppConstants.Design.cornerRadius)
                                        .fill(Color.white)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: AppConstants.Design.cornerRadius)
                                                .stroke(Color.black, lineWidth: AppConstants.Design.lineWidth)
                                        )
                                )
                        }
                        
                        // Seleção de Ícone
                        VStack(alignment: .leading, spacing: 12) {
                            Text(AppConstants.Messages.chooseIconLabel)
                                .font(.system(.caption, design: .rounded))
                                .fontWeight(.black)
                                .foregroundColor(.secondary)
                                .tracking(AppConstants.Design.trackingStandard)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(icons, id: \.self) { icon in
                                        Image(icon)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 44, height: 44)
                                            .padding(10)
                                            .background(
                                                RoundedRectangle(cornerRadius: AppConstants.Design.cornerRadius)
                                                    .fill(selectedIcon == icon ? Color(hex: AppConstants.Colors.selectionBackground) : Color.white)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: AppConstants.Design.cornerRadius)
                                                            .stroke(Color.black, lineWidth: AppConstants.Design.lineWidth)
                                                    )
                                                    .shadow(color: .black, radius: 0, x: selectedIcon == icon ? 0 : AppConstants.Design.shadowOffset, y: selectedIcon == icon ? 0 : AppConstants.Design.shadowOffset)
                                            )
                                            .scaleEffect(selectedIcon == icon ? 0.95 : 1.0)
                                            .onTapGesture {
                                                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                                    selectedIcon = icon
                                                    haptic.selectionChanged()
                                                }
                                            }
                                    }
                                }
                                .padding(.horizontal, 4)
                                .padding(.bottom, 8)
                            }
                        }
                        
                        // Seleção de Cor
                        VStack(alignment: .leading, spacing: 12) {
                            Text(AppConstants.Messages.chooseColorLabel)
                                .font(.system(.caption, design: .rounded))
                                .fontWeight(.black)
                                .foregroundColor(.secondary)
                                .tracking(AppConstants.Design.trackingStandard)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(colors, id: \.self) { color in
                                        Circle()
                                            .fill(Color(hex: color))
                                            .frame(width: 40, height: 40)
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.black, lineWidth: AppConstants.Design.lineWidth)
                                            )
                                            .background(
                                                Circle()
                                                    .fill(Color.black)
                                                    .offset(x: selectedColor == color ? 0 : AppConstants.Design.shadowOffset, y: selectedColor == color ? 0 : AppConstants.Design.shadowOffset)
                                            )
                                            .scaleEffect(selectedColor == color ? 0.95 : 1.0)
                                            .onTapGesture {
                                                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                                    selectedColor = color
                                                    haptic.selectionChanged()
                                                }
                                            }
                                    }
                                }
                                .padding(.vertical, 20)
                                .padding(.horizontal, 4)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer()
                        .frame(height: 32)
                }
                
                // Botões de Ação
                VStack(spacing: 12) {
                    Button(action: {
                        let newItem = SushiItem(nome: nome, icon: selectedIcon, color: selectedColor)
                        modelContext.insert(newItem)
                        try? modelContext.save()
                        dismiss()
                    }) {
                        Text(AppConstants.Messages.addSushiButtonLabel)
                            .font(.system(.headline, design: .rounded))
                            .fontWeight(.black)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(
                                RoundedRectangle(cornerRadius: AppConstants.Design.cornerRadius)
                                    .fill(nome.isEmpty ? Color(hex: AppConstants.Colors.disabled) : Color(hex: AppConstants.Colors.accentPrimary))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: AppConstants.Design.cornerRadius)
                                            .stroke(Color.black, lineWidth: AppConstants.Design.lineWidth)
                                    )
                                    .shadow(color: .black.opacity(nome.isEmpty ? 0.3 : 1), radius: 0, x: AppConstants.Design.shadowOffset, y: AppConstants.Design.shadowOffset)
                            )
                    }
                    .disabled(nome.isEmpty)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
            }
        }
    }
}

#Preview {
    AddSushiView()
        .modelContainer(for: SushiItem.self, inMemory: true)
}
