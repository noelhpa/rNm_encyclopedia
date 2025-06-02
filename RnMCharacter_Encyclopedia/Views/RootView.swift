//
//  RootView.swift
//  RnMCharacter_Encyclopedia
//
//  Created by Noel Hiram Pat Angulo on 5/31/25.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var coordinator: AppCoordinator

    var body: some View {
        if let error = coordinator.error {
            ErrorView(error: error) {
                coordinator.error = nil
                coordinator.start()
            }
        } else if coordinator.isReady {
            coordinator.createView()
        } else {
            ProgressView("loading...")
                .task {
                    coordinator.start()
                }
        }
    }
}
