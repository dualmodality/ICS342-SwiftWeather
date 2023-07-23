//
//  SwiftWeatherApp.swift
//  SwiftWeather
//
//  Created by Joselyn on 7/17/23.
//

import SwiftUI

@main
struct SwiftWeatherApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CurrentConditionsView(viewModel: CurrentConditionsViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
