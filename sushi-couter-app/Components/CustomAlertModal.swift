import SwiftUI

struct CustomAlertModal: View {
    let title: String
    let message: String
    let buttonLabel: String
    let onDismiss: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    onDismiss()
                }

            VStack(spacing: 24) {
                VStack(spacing: 12) {
                    Text(title)
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

                Button(action: onDismiss) {
                    Text(buttonLabel)
                        .font(.system(.headline, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.black)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.black, lineWidth: 3)
                                )
                        )
                }
            }
            .padding(32)
            .background(Color(hex: AppConstants.Colors.background))
            .cornerRadius(AppConstants.Design.modalCornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: AppConstants.Design.modalCornerRadius)
                    .stroke(Color.black, lineWidth: AppConstants.Design.lineWidth)
            )
            .padding(32)
            .shadow(color: .black, radius: 0, x: AppConstants.Design.modalShadowOffset, y: AppConstants.Design.modalShadowOffset)
            .transition(.opacity.combined(with: .scale(0.9)))
        }
    }
}

#Preview {
    CustomAlertModal(
        title: "Registro Salvo! ✅",
        message: "Seu consumo diário foi salvo com sucesso.",
        buttonLabel: "OK",
        onDismiss: {}
    )
}
