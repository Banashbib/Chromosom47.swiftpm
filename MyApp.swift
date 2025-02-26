import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            Start()
                .environment(\.horizontalSizeClass, .compact)
                .preferredColorScheme(.light)
        }
    }
}
