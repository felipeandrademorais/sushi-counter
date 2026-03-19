import SwiftUI

struct HeaderView: View {
    let canSave: Bool
    let onReset: () -> Void
    let onHistory: () -> Void
    let onSave: () -> Void
    let onShare: () -> Void
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
                // Menu contextual (ações secundárias)
                MenuButton(
                    canSave: canSave,
                    onHistory: onHistory,
                    onSave: onSave,
                    onShare: onShare
                )

                // Reset (ação primária)
                HeaderButton(
                    icon: AppConstants.Icons.refresh,
                    foreground: .black,
                    background: .white,
                    showStroke: true,
                    action: onReset
                )

                // Add (ação primária - CTA)
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

// MARK: - Menu Button

private struct MenuButton: View {
    let canSave: Bool
    let onHistory: () -> Void
    let onSave: () -> Void
    let onShare: () -> Void

    var body: some View {
        Menu {
            Button(action: onHistory) {
                Label(
                    AppConstants.Messages.menuHistoryLabel,
                    systemImage: AppConstants.Icons.history
                )
            }

            Button(action: onSave) {
                Label(
                    AppConstants.Messages.menuSaveLabel,
                    systemImage: AppConstants.Icons.save
                )
            }
            .disabled(!canSave)

            Divider()

            Button(action: onShare) {
                Label(
                    AppConstants.Messages.menuShareLabel,
                    systemImage: AppConstants.Icons.share
                )
            }
        } label: {
            Image(systemName: AppConstants.Icons.menu)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(10)
                .background(
                    Circle()
                        .fill(.white)
                        .overlay(
                            Circle().stroke(Color.black, lineWidth: AppConstants.Design.headerLineWidth)
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
    HeaderView(canSave: true, onReset: {}, onHistory: {}, onSave: {}, onShare: {}, onAdd: {})
        .background(Color(hex: AppConstants.Colors.background))
}
