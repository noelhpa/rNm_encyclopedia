//
//  ErrorView.swift
//  RnMCharacter_Encyclopedia
//
//  Created by Noel Hiram Pat Angulo on 5/31/25.
//

import SwiftUI

struct ErrorView: View {
    private let error: RMNetworkError
    private let retry: () -> Void

    // MARK: Initialization
    init(error: RMNetworkError, retry: @escaping () -> Void) {
        self.error = error
        self.retry = retry
    }

    // MARK: UIBody
    var body: some View {
        VStack(spacing: 20) {
            icon
            Text(message)
                .font(.headline)
            Button(RMText.localized(key: "try_again"), action: retry)
        }
        .padding()
    }

    // MARK: Screen central icon
    private var icon: some View {
        switch error {
        case .noInternetConnection:
            return Image(systemName: "wifi.slash")
        case .unauthorized:
            return Image(systemName: "lock.slash")
        case .notFound:
            return Image(systemName: "magnifyingglass")
        default:
            return Image(systemName: "exclamationmark.triangle")
        }
    }

    // MARK: Screen central error text
    private var message: String {
        switch error {
        case .noInternetConnection:
            return RMText.localized(key: "error_no_internet")
        case .unauthorized:
            return RMText.localized(key: "error_unauthorized")
        case .notFound:
            return RMText.localized(key: "error_not_found")
        case .badRequest:
            return RMText.localized(key: "error_bad_request")
        case .serverError(let status):
            return RMText.localized(key: "error_server", args: status)
        case .unhandled(let status):
            return RMText.localized(key: "error_unhandled", args: status)
        }
    }
}
