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
            PersistedProfileModel.self
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
                NavigationStack {
                    Text("stats page")
                        .padding(.vertical)
                }
                .tabItem {
                    Image(systemName: "chart.pie")
                    Text("Statistics")
                }
                
                NavigationStack {
                 Text("habit page")
                    .padding(.vertical)
                }
                .tabItem {
                    Image(systemName: "circle.hexagongrid")
                    Text("Habits")
                }
                
                NavigationStack {
                    profileView()
                        .padding(.vertical)
                }
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
                
            }
            .accentColor(.darkCharcoal)
        }
        .modelContainer(sharedModelContainer)
    }
}

private func profileView() -> some View {
    @Inject(BindingName.accountBindingName) var profileView: AnyView!
    return profileView
}
