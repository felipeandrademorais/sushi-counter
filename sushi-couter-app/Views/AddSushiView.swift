import SwiftUI
import SwiftData

struct AddSushiView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var nome: String = ""
    @State private var selectedIcon: String = "nigiri"
    @State private var selectedColor: String = AppConstants.Colors.harumaki
    @State private var caloriasPorPeca: Int = 0

    private let icons = AppConstants.Icons.all
    private let colors = AppConstants.Colors.allItemColors
    private let haptic = UISelectionFeedbackGenerator()

    // MARK: - Body

    var body: some View {
        ZStack {
            Color(hex: AppConstants.Colors.background).ignoresSafeArea()

            VStack(spacing: 24) {
                Text(AppConstants.Messages.newSushiTitle)
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.black)
                    .padding(.top, 24)

                formContent

                addButton
                    .padding(.horizontal, 24)
            }
        }
    }

    // MARK: - Subviews

    private var formContent: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                nameField
                caloriesField
                iconPicker
                colorPicker
            }
            .padding(.horizontal, 24)

            Spacer()
                .frame(height: 32)
        }
    }

    private var nameField: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionLabel(AppConstants.Messages.sushiNameLabel)

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
    }

    private var caloriesField: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionLabel(AppConstants.Messages.caloriesPerPieceLabel)

            TextField(
                AppConstants.Messages.caloriesPerPiecePlaceholder,
                value: $caloriasPorPeca,
                format: .number
            )
            .keyboardType(.numberPad)
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
    }

    private var iconPicker: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionLabel(AppConstants.Messages.chooseIconLabel)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(icons, id: \.self) { icon in
                        IconOption(
                            icon: icon,
                            isSelected: selectedIcon == icon,
                            onTap: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                    selectedIcon = icon
                                    haptic.selectionChanged()
                                }
                            }
                        )
                    }
                }
                .padding(.horizontal, 4)
                .padding(.bottom, 8)
            }
        }
    }

    private var colorPicker: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionLabel(AppConstants.Messages.chooseColorLabel)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(colors, id: \.self) { color in
                        ColorOption(
                            color: color,
                            isSelected: selectedColor == color,
                            onTap: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                    selectedColor = color
                                    haptic.selectionChanged()
                                }
                            }
                        )
                    }
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 4)
            }
        }
    }

    private var addButton: some View {
        Button(action: {
            SushiDataService.addItem(
                nome: nome,
                icon: selectedIcon,
                color: selectedColor,
                calorias: caloriasPorPeca,
                context: modelContext
            )
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
                        .fill(nome.isEmpty
                              ? Color(hex: AppConstants.Colors.disabled)
                              : Color(hex: AppConstants.Colors.accentPrimary))
                        .overlay(
                            RoundedRectangle(cornerRadius: AppConstants.Design.cornerRadius)
                                .stroke(Color.black, lineWidth: AppConstants.Design.lineWidth)
                        )
                        .shadow(
                            color: .black.opacity(nome.isEmpty ? 0.3 : 1),
                            radius: 0,
                            x: AppConstants.Design.shadowOffset,
                            y: AppConstants.Design.shadowOffset
                        )
                )
        }
        .disabled(nome.isEmpty)
    }
}

// MARK: - Private Subcomponents

private struct SectionLabel: View {
    let text: String

    init(_ text: String) { self.text = text }

    var body: some View {
        Text(text)
            .font(.system(.caption, design: .rounded))
            .fontWeight(.black)
            .foregroundColor(.secondary)
            .tracking(AppConstants.Design.trackingStandard)
    }
}

private struct IconOption: View {
    let icon: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Image(icon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 44, height: 44)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: AppConstants.Design.cornerRadius)
                    .fill(isSelected
                          ? Color(hex: AppConstants.Colors.selectionBackground)
                          : Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: AppConstants.Design.cornerRadius)
                            .stroke(Color.black, lineWidth: AppConstants.Design.lineWidth)
                    )
                    .shadow(
                        color: .black,
                        radius: 0,
                        x: isSelected ? 0 : AppConstants.Design.shadowOffset,
                        y: isSelected ? 0 : AppConstants.Design.shadowOffset
                    )
            )
            .scaleEffect(isSelected ? 0.95 : 1.0)
            .onTapGesture(perform: onTap)
    }
}

private struct ColorOption: View {
    let color: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Circle()
            .fill(Color(hex: color))
            .frame(width: 40, height: 40)
            .overlay(
                Circle().stroke(Color.black, lineWidth: AppConstants.Design.lineWidth)
            )
            .background(
                Circle()
                    .fill(Color.black)
                    .offset(
                        x: isSelected ? 0 : AppConstants.Design.shadowOffset,
                        y: isSelected ? 0 : AppConstants.Design.shadowOffset
                    )
            )
            .scaleEffect(isSelected ? 0.95 : 1.0)
            .onTapGesture(perform: onTap)
    }
}

#Preview {
    AddSushiView()
        .modelContainer(for: SushiItem.self, inMemory: true)
}
