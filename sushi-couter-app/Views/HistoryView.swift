import SwiftUI
import SwiftData

struct HistoryView: View {
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \DailyConsumptionLog.createdAt, order: .reverse) private var logs: [DailyConsumptionLog]

    var body: some View {
        ZStack {
            Color(hex: AppConstants.Colors.background).ignoresSafeArea()
            DotPatternBackground()

            VStack(spacing: 16) {
                header

                if logs.isEmpty {
                    emptyState
                } else {
                    logsList
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
    }

    private var header: some View {
        HStack {
            Text(AppConstants.Messages.historyTitle)
                .font(.system(.title2, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(.black)

            Spacer()

            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.black)
                    .padding(10)
                    .background(
                        Circle()
                            .fill(Color.white)
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
            .buttonStyle(.plain)
        }
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Text(AppConstants.Messages.historyEmptyState)
                .font(.system(.body, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var logsList: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                ForEach(logs) { log in
                    HistoryRow(log: log)
                }
            }
            .padding(.bottom, 24)
        }
    }
}

private struct HistoryRow: View {
    let log: DailyConsumptionLog

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(log.createdAt.formatted(date: .abbreviated, time: .shortened))
                .font(.system(.caption, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(.secondary)
                .tracking(AppConstants.Design.trackingStandard)

            HStack {
                Text("\(AppConstants.Messages.historySushiLabel): \(log.totalSushis)")
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.black)
                    .foregroundColor(.black)

                Spacer()

                Text("\(AppConstants.Messages.historyCaloriesLabel): \(log.totalCalorias) kcal")
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.black)
                    .foregroundColor(.black)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.black, lineWidth: AppConstants.Design.lineWidth)
                )
                .shadow(color: .black, radius: 0, x: AppConstants.Design.shadowOffset, y: AppConstants.Design.shadowOffset)
        )
    }
}

#Preview {
    HistoryView()
        .modelContainer(for: [SushiItem.self, DailyConsumptionLog.self], inMemory: true)
}
