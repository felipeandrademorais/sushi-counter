import SwiftUI
import Photos

struct ShareSheetView: View {
    let totalPecas: Int
    let totalCalorias: Int

    @State private var isTransparent = false
    @State private var showSavedAlert = false
    @State private var savedAlertMessage = ""
    @State private var renderedImage: UIImage?
    @Environment(\.dismiss) private var dismiss
    @Environment(\.displayScale) private var displayScale

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 24) {
                    // Preview do card
                    ZStack {
                        if isTransparent {
                            checkerboardBackground
                                .clipShape(RoundedRectangle(cornerRadius: AppConstants.Design.modalCornerRadius))
                        }

                        ShareCardView(
                            totalPecas: totalPecas,
                            totalCalorias: totalCalorias,
                            isTransparent: isTransparent
                        )
                    }
                    .padding(.top, 16)

                    // Toggle transparência
                    Toggle(isOn: $isTransparent) {
                        HStack(spacing: 8) {
                            Image(systemName: "square.on.square.dashed")
                                .font(.body)
                                .fontWeight(.bold)
                            Text(AppConstants.Messages.shareTransparentToggle)
                                .font(.system(.body, design: .rounded))
                                .fontWeight(.bold)
                        }
                    }
                    .tint(Color(hex: AppConstants.Colors.accentPrimary))
                    .padding(.horizontal, 24)

                    // Botões de ação
                    VStack(spacing: 12) {
                        // Salvar no celular
                        Button(action: saveToPhotos) {
                            HStack(spacing: 8) {
                                Image(systemName: "square.and.arrow.down")
                                    .font(.body)
                                    .fontWeight(.bold)
                                Text(AppConstants.Messages.shareSaveToPhotosLabel)
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.black)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: AppConstants.Design.cornerRadius)
                                    .fill(Color.black)
                                    .shadow(
                                        color: .black.opacity(0.15),
                                        radius: 0,
                                        x: AppConstants.Design.shadowOffset,
                                        y: AppConstants.Design.shadowOffset
                                    )
                            )
                        }

                        // Compartilhar
                        if let image = renderedImage {
                            ShareLink(
                                item: Image(uiImage: image),
                                preview: SharePreview(
                                    AppConstants.Messages.shareBranding,
                                    image: Image(uiImage: image)
                                )
                            ) {
                                HStack(spacing: 8) {
                                    Image(systemName: AppConstants.Icons.share)
                                        .font(.body)
                                        .fontWeight(.bold)
                                    Text(AppConstants.Messages.shareButtonLabel)
                                        .font(.system(.body, design: .rounded))
                                        .fontWeight(.black)
                                }
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(
                                    RoundedRectangle(cornerRadius: AppConstants.Design.cornerRadius)
                                        .fill(Color.white)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: AppConstants.Design.cornerRadius)
                                                .stroke(Color.black, lineWidth: AppConstants.Design.lineWidth)
                                        )
                                        .shadow(
                                            color: .black.opacity(0.15),
                                            radius: 0,
                                            x: AppConstants.Design.shadowOffset,
                                            y: AppConstants.Design.shadowOffset
                                        )
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 24)

                    Spacer()
                }

                // Save success modal
                if showSavedAlert {
                    CustomAlertModal(
                        title: savedAlertMessage,
                        message: "",
                        buttonLabel: AppConstants.Messages.okButton,
                        onDismiss: {
                            withAnimation(.spring()) {
                                showSavedAlert = false
                            }
                        }
                    )
                    .zIndex(100)
                }
            }
            .navigationTitle(AppConstants.Messages.shareSheetTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .onAppear { updateRenderedImage() }
            .onChange(of: isTransparent) { updateRenderedImage() }
        }
    }

    // MARK: - Image Rendering

    private func updateRenderedImage() {
        let cardView = ShareCardView(
            totalPecas: totalPecas,
            totalCalorias: totalCalorias,
            isTransparent: isTransparent
        )

        let renderer = ImageRenderer(content: cardView)
        renderer.scale = displayScale
        renderer.isOpaque = !isTransparent

        renderedImage = renderer.uiImage
    }

    // MARK: - Save to Photos

    private func saveToPhotos() {
        updateRenderedImage()
        guard let image = renderedImage else { return }

        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        savedAlertMessage = AppConstants.Messages.shareSavedSuccess
        showSavedAlert = true
        let haptic = UINotificationFeedbackGenerator()
        haptic.notificationOccurred(.success)
    }

    // MARK: - Checkerboard

    private var checkerboardBackground: some View {
        Canvas { context, size in
            let tileSize: CGFloat = 10
            for row in 0..<Int(size.height / tileSize) + 1 {
                for col in 0..<Int(size.width / tileSize) + 1 {
                    if (row + col).isMultiple(of: 2) {
                        context.fill(
                            Path(
                                CGRect(
                                    x: CGFloat(col) * tileSize,
                                    y: CGFloat(row) * tileSize,
                                    width: tileSize,
                                    height: tileSize
                                )
                            ),
                            with: .color(.gray.opacity(0.15))
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    ShareSheetView(totalPecas: 45, totalCalorias: 6750)
}
