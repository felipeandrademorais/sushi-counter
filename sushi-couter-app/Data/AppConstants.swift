import SwiftUI

struct AppConstants {
    struct Colors {
        static let background = "F9F7F2"
        static let destructive = "FF3B30"
        static let primaryText = "000000"
        static let secondaryText = "666666"
        static let selectionBackground = "FFF9C4"
        static let disabled = "A0A0A0"
        static let accentPrimary = "FF8C32"
        
        // Cores dos itens padrão do Seed
        static let harumaki = "FF5E5E"
        static let hossomaki = "4E9F3D"
        static let hot = "FFB319"
        static let joe = "FF8C32"
        static let nigiri = "845EC2"
        static let sashimi = "D65DB1"
        static let tiradito = "4B4453"
        static let uramaki = "C34A36"

        static let allItemColors = [harumaki, hossomaki, hot, joe, nigiri, sashimi, tiradito, uramaki]
    }
    
    struct Icons {
        static let all = ["harumaki", "hossomaki", "hot", "joe", "nigiri", "sashimi", "tiradito", "uramaki"]
        static let refresh = "arrow.counterclockwise"
        static let add = "plus"
        static let save = "tray.and.arrow.down.fill"
        static let history = "clock.arrow.circlepath"
        static let menu = "ellipsis"
        static let share = "square.and.arrow.up"
    }
    
    struct Design {
        static let lineWidth: CGFloat = 3
        static let headerLineWidth: CGFloat = 2
        static let cornerRadius: CGFloat = 16
        static let modalCornerRadius: CGFloat = 24
        static let shadowOffset: CGFloat = 4
        static let modalShadowOffset: CGFloat = 8
        static let headerShadowOffset: CGFloat = 2
        
        static let dotPatternSpacing: CGFloat = 40
        static let dotPatternSize: CGFloat = 2
        static let dotPatternOpacity: Double = 0.03
        
        static let heroNumberSize: CGFloat = 96
        static let trackingWide: CGFloat = 2
        static let trackingStandard: CGFloat = 1
    }
    
    struct Limits {
        static let maxPerItem = 99
        static let maxTotalConsumed = 999
    }
    
    struct Messages {
        static let funnyDeletions: [String] = [
            L10n.text("messages.funnyDeletion.1"),
            L10n.text("messages.funnyDeletion.2"),
            L10n.text("messages.funnyDeletion.3"),
            L10n.text("messages.funnyDeletion.4"),
            L10n.text("messages.funnyDeletion.5"),
            L10n.text("messages.funnyDeletion.6"),
            L10n.text("messages.funnyDeletion.7")
        ]

        static let funnyShareMessages: [String] = [
            L10n.text("messages.funnyShare.1"),
            L10n.text("messages.funnyShare.2"),
            L10n.text("messages.funnyShare.3"),
            L10n.text("messages.funnyShare.4"),
            L10n.text("messages.funnyShare.5"),
            L10n.text("messages.funnyShare.6"),
            L10n.text("messages.funnyShare.7")
        ]
        
        static let appTitle = L10n.text("messages.appTitle")
        static let totalConsumedLabel = L10n.text("messages.totalConsumedLabel")
        static let menuLabel = L10n.text("messages.menuLabel")
        static let footerLabel = L10n.text("messages.footerLabel")
        static let newSushiTitle = L10n.text("messages.newSushiTitle")
        static let sushiNamePlaceholder = L10n.text("messages.sushiNamePlaceholder")
        static let sushiNameLabel = L10n.text("messages.sushiNameLabel")
        static let caloriesPerPieceLabel = L10n.text("messages.caloriesPerPieceLabel")
        static let caloriesPerPiecePlaceholder = L10n.text("messages.caloriesPerPiecePlaceholder")
        static let chooseIconLabel = L10n.text("messages.chooseIconLabel")
        static let chooseColorLabel = L10n.text("messages.chooseColorLabel")
        static let addSushiButtonLabel = L10n.text("messages.addSushiButtonLabel")
        static let saveConsumptionSuccessTitle = L10n.text("messages.saveConsumptionSuccessTitle")
        static let saveConsumptionSuccessMessage = L10n.text("messages.saveConsumptionSuccessMessage")
        static let historyTitle = L10n.text("messages.historyTitle")
        static let historyEmptyState = L10n.text("messages.historyEmptyState")
        static let historySushiLabel = L10n.text("messages.historySushiLabel")
        static let historyCaloriesLabel = L10n.text("messages.historyCaloriesLabel")
        static let deleteModalCancel = L10n.text("messages.deleteModalCancel")
        static let deleteModalConfirm = L10n.text("messages.deleteModalConfirm")
        static let deleteModalTitleFormat = L10n.text("messages.deleteModalTitleFormat")
        static let okButton = L10n.text("messages.okButton")

        // Menu labels
        static let menuHistoryLabel = L10n.text("messages.menuHistoryLabel")
        static let menuSaveLabel = L10n.text("messages.menuSaveLabel")
        static let menuShareLabel = L10n.text("messages.menuShareLabel")

        // Share sheet labels
        static let shareSheetTitle = L10n.text("messages.shareSheetTitle")
        static let shareTransparentToggle = L10n.text("messages.shareTransparentToggle")
        static let shareButtonLabel = L10n.text("messages.shareButtonLabel")
        static let shareBranding = L10n.text("messages.shareBranding")
        static let shareSaveToPhotosLabel = L10n.text("messages.shareSaveToPhotosLabel")
        static let shareSavedSuccess = L10n.text("messages.shareSavedSuccess")
        static let shareSavedError = L10n.text("messages.shareSavedError")
    }
}
