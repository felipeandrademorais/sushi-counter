import SwiftUI

struct DotPatternBackground: View {
    var body: some View {
        Canvas { context, size in
            let spacing = AppConstants.Design.dotPatternSpacing
            let dotSize = AppConstants.Design.dotPatternSize
            let opacity = AppConstants.Design.dotPatternOpacity

            for x in stride(from: 0, through: size.width, by: spacing) {
                for y in stride(from: 0, through: size.height, by: spacing) {
                    context.fill(
                        Path(ellipseIn: CGRect(x: x, y: y, width: dotSize, height: dotSize)),
                        with: .color(Color.black.opacity(opacity))
                    )
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ZStack {
        Color(hex: AppConstants.Colors.background).ignoresSafeArea()
        DotPatternBackground()
    }
}
