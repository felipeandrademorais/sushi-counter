import SwiftUI

struct CustomDeleteModal: View {
    let item: SushiItem
    let message: String
    let onCancel: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    onCancel()
                }
            
            VStack(spacing: 24) {
                VStack(spacing: 12) {
                    Text(String(format: AppConstants.Messages.deleteModalTitleFormat, item.nome))
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.black)
                        .multilineTextAlignment(.center)
                    
                    Text(message)
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                HStack(spacing: 16) {
                    Button(action: onCancel) {
                        Text(AppConstants.Messages.deleteModalCancel)
                            .font(.system(.headline, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color.black, lineWidth: 3)
                                    )
                            )
                    }
                    
                    Button(action: onDelete) {
                        Text(AppConstants.Messages.deleteModalConfirm)
                            .font(.system(.headline, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(hex: "FF3B30"))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color.black, lineWidth: 3)
                                    )
                            )
                    }
                }
            }
            .padding(32)
            .background(Color(hex: "F9F7F2"))
            .cornerRadius(24)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color.black, lineWidth: 3)
            )
            .padding(32)
            .shadow(color: .black, radius: 0, x: 8, y: 8)
            .transition(.opacity.combined(with: .scale(0.9)))
        }
    }
}

#Preview {
    CustomDeleteModal(
        item: SushiItem(nome: "Sashimi", icon: "sashimi", color: "FF5E5E"),
        message: "Você realmente vai fazer isso? O sushiman vai ficar triste! 👨‍🍳💔",
        onCancel: {},
        onDelete: {}
    )
}
