//
//  LocalizableText.swift
//  RnMCharacter_Encyclopedia
//
//  Created by Noel Hiram Pat Angulo on 6/2/25.
//

import Foundation

enum RMText {
    static func localized(key: String) -> String {
        NSLocalizedString(key, comment: "")
    }

    static func localized(key: String, args: CVarArg...) -> String {
        let format = NSLocalizedString(key, comment: "")
        return String(format: format, arguments: args)
    }
}
