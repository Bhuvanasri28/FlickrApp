//
//  FlickrAppApp.swift
//  FlickrApp
//
//  Created by Bhuvana Ravuri on 11/19/24.
//

import SwiftUI

@main
struct FlickrAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            FlickrAppView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
