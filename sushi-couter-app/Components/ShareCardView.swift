import SwiftUI

struct ShareCardView: View {
    let totalPecas: Int
    let totalCalorias: Int
    let isTransparent: Bool

    private var funnyMessage: String {
        let messages = AppConstants.Messages.funnyShareMessages
        guard !messages.isEmpty else { return "" }
        let template = messages[totalPecas % messages.count]
        return String(format: template, totalPecas)
    }

    private var accentColor: Color {
        if totalPecas <= 10 {
            return .black
        } else if totalPecas <= 25 {
            return Color(hex: AppConstants.Colors.accentPrimary)
        } else {
            return Color(hex: AppConstants.Colors.destructive)
        }
    }

    var body: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 8)

            // Branding
            Text(AppConstants.Messages.shareBranding)
                .font(.system(.title3, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(.black)

            // Total number
            HStack(spacing: 8) {
                if totalPecas > 35 {
                    Text("🔥")
                        .font(.system(size: 36))
                }

                Text("\(totalPecas)")
                    .font(.system(size: 72, weight: .black, design: .rounded))
                    .foregroundColor(accentColor)

                if totalPecas > 35 {
                    Text("🔥")
                        .font(.system(size: 36))
                }
            }

            // Stats
            VStack(spacing: 4) {
                Text(AppConstants.Messages.totalConsumedLabel)
                    .font(.system(.caption, design: .rounded))
                    .fontWeight(.black)
                    .foregroundColor(.secondary)
                    .tracking(AppConstants.Design.trackingWide)

                Text("\(totalCalorias) kcal")
                    .font(.system(.caption, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
            }

            // Funny message
            Text(funnyMessage)
                .font(.system(.body, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.black.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)

            // Date
            Text(Date.now.formatted(.dateTime.weekday(.wide).day().month(.wide).year()))
                .font(.system(.caption2, design: .rounded))
                .fontWeight(.medium)
                .foregroundColor(.secondary)

            Spacer().frame(height: 8)
        }
        .padding(24)
        .frame(width: 320)
        .background(
            Group {
                if isTransparent {
                    Color.clear
                } else {
                    RoundedRectangle(cornerRadius: AppConstants.Design.modalCornerRadius)
                        .fill(Color(hex: AppConstants.Colors.background))
                        .overlay(
                            RoundedRectangle(cornerRadius: AppConstants.Design.modalCornerRadius)
                                .stroke(Color.black, lineWidth: AppConstants.Design.lineWidth)
                        )
                        .shadow(
                            color: .black.opacity(0.15),
                            radius: 0,
                            x: AppConstants.Design.shadowOffset,
                            y: AppConstants.Design.shadowOffset
                        )
                }
            }
        )
    }
}

#Preview {
    VStack(spacing: 20) {
        ShareCardView(totalPecas: 45, totalCalorias: 6750, isTransparent: false)
        ShareCardView(totalPecas: 12, totalCalorias: 1800, isTransparent: true)
            .background(Color.gray.opacity(0.2))
    }
}
