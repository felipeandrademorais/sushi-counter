import Foundation

enum L10n {
    private static var preferredLanguageCode: String {
        Locale.preferredLanguages.first?.hasPrefix("en") == true ? "en" : "pt-BR"
    }

    private static var bundle: Bundle {
        guard
            let path = Bundle.main.path(forResource: preferredLanguageCode, ofType: "lproj"),
            let languageBundle = Bundle(path: path)
        else {
            return .main
        }
        return languageBundle
    }

    static func text(_ key: String) -> String {
        NSLocalizedString(key, tableName: "Localizable", bundle: bundle, value: key, comment: "")
    }

    static func format(_ key: String, _ args: CVarArg...) -> String {
        String(format: text(key), locale: Locale.current, arguments: args)
    }
}
