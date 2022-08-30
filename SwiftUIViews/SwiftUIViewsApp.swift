import SwiftUI

@main
struct SwiftUIViewsApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = HomeViewModel()
            HomeView(viewModel: viewModel)
        }
    }
}
