import SwiftUI

struct TotalHeroCard: View {
    let total: Int

    var body: some View {
        VStack(spacing: 4) {
            Text(AppConstants.Messages.totalConsumedLabel)
                .font(.system(.caption, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(.secondary)
                .tracking(AppConstants.Design.trackingWide)

            Text("\(total)")
                .font(.system(size: AppConstants.Design.heroNumberSize, weight: .black, design: .rounded))
                .foregroundColor(.black)
                .contentTransition(.numericText())
                .overlay(
                    Text("\(total)")
                        .font(.system(size: AppConstants.Design.heroNumberSize, weight: .black, design: .rounded))
                        .offset(x: 3, y: 3)
                        .foregroundColor(.black.opacity(0.1))
                        .zIndex(-1)
                )
        }
        .padding(.vertical, 20)
    }
}

#Preview {
    TotalHeroCard(total: 42)
        .background(Color(hex: AppConstants.Colors.background))
}
