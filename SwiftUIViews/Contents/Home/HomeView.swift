import SwiftUI

struct HomeView: View {
    
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(
                    viewModel.state.listTypes.indices,
                    id: \.self
                ) { index in
                    NavigationLink(
                        destination: ListPagerView(viewModel: ListPagerViewModel())
                    ) {
                        let title = viewModel.state.listTypes[index].title
                        let description = viewModel.state.listTypes[index].description
                        homeListCellView(
                            title: title,
                            description: description)
                    }
                    .navigationTitle("SwiftUIViews")
                }
            }
        }
    }
    
    private func homeListCellView(
        title: String,
        description: String
    ) -> some View {
        VStack(
            alignment: .leading,
            spacing: 8
        ) {
            Text(title)
                .fontWeight(.bold)
                .font(.system(size: 16))
                .foregroundColor(.black)
            Text(description)
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
