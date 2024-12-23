//
//  momentumApp.swift
//  momentum
//
//  Created by Bronwyn dos Santos on 2024/12/23.
//

import SwiftUI
import SwiftData

@main
struct momentumApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                OnboardingView(viewModel: StatisticOnboardingViewModel(), intents: InitialOnboardingIntents())
                    .tabItem {
                        Image(systemName: "chart.pie")
                        Text("Statistics")
                    }
                
                OnboardingView(viewModel: HabitOnboardingViewModel(), intents: InitialOnboardingIntents())
                    .tabItem {
                        Image(systemName: "circle.hexagongrid")
                        Text("Habits")
                    }
                
                ProfileView(viewModel: AccountViewModel(), intents: AccountIntents())
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Profile")
                    }
            }
            .accentColor(.orange)
        }
        .modelContainer(sharedModelContainer)
    }
}
