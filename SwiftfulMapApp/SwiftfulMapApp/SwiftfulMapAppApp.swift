//
//  SwiftfulMapAppApp.swift
//  SwiftfulMapApp
//
//  Created by Alexandru Tenie on 06.01.2023.
//

import SwiftUI

@main
struct SwiftfulMapAppApp: App {
    @StateObject private var viewModel: LocationsViewModel = LocationsViewModel()

    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(viewModel)
        }
    }
}
