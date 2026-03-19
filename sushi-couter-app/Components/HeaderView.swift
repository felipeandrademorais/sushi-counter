import SwiftUI

struct HeaderView: View {
    let onReset: () -> Void
    let onHistory: () -> Void
    let onSave: () -> Void
    let onAdd: () -> Void

    var body: some View {
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
                HeaderButton(
                    icon: AppConstants.Icons.refresh,
                    foreground: .black,
                    background: .white,
                    showStroke: true,
                    action: onReset
                )

                HeaderButton(
                    icon: AppConstants.Icons.history,
                    foreground: .black,
                    background: .white,
                    showStroke: true,
                    action: onHistory
                )
                
                HeaderButton(
                    icon: AppConstants.Icons.save,
                    foreground: .black,
                    background: .white,
                    showStroke: true,
                    action: onSave
                )

                HeaderButton(
                    icon: AppConstants.Icons.add,
                    foreground: .white,
                    background: .black,
                    showStroke: false,
                    action: onAdd
                )
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 20)
    }
}

// MARK: - Header Button

private struct HeaderButton: View {
    let icon: String
    let foreground: Color
    let background: Color
    let showStroke: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(foreground)
                .padding(10)
                .background(
                    Circle()
                        .fill(background)
                        .overlay(
                            showStroke
                                ? Circle().stroke(Color.black, lineWidth: AppConstants.Design.headerLineWidth)
                                : nil
                        )
                        .shadow(
                            color: .black.opacity(0.1),
                            radius: 0,
                            x: AppConstants.Design.headerShadowOffset,
                            y: AppConstants.Design.headerShadowOffset
                        )
                )
        }
    }
}

#Preview {
    HeaderView(onReset: {}, onHistory: {}, onSave: {}, onAdd: {})
        .background(Color(hex: AppConstants.Colors.background))
}
