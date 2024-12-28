import SwiftUI
import FictionalInjection
import SwiftData

@main
struct momentumApp: App {
    var bindDependencies: () = {
        let accountDependencies = AccountDependencies()
        accountDependencies.bindAccountDependencies()
    }()
    
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
                    .padding(.vertical)
                    .tabItem {
                        Image(systemName: "chart.pie")
                        Text("Statistics")
                    }
            
                OnboardingView(viewModel: HabitOnboardingViewModel(),
                               intents: HabitOnboardingIntents())
                    .padding(.vertical)
                    .tabItem {
                        Image(systemName: "circle.hexagongrid")
                        Text("Habits")
                    }
               
                profileView()
                    .padding(.vertical)
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

private func profileView() -> some View {
    @Inject(BindingName.accountBindingName) var profileView: AnyView!
    return profileView
}
