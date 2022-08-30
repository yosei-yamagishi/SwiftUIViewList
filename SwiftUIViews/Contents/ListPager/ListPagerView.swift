import SwiftUI

struct ListPagerView: View {
    @ObservedObject private var viewModel: ListPagerViewModel = ListPagerViewModel()
    
    init(viewModel: ListPagerViewModel) {
        self.viewModel = viewModel
        // List全体の背景色の設定
        UITableView.appearance().backgroundColor = UIColor.white
        UITableView.appearance().separatorColor = .clear
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.white.ignoresSafeArea()
            List {
                Section {
                    profileInfoCellView()
                }
                Section(
                    header: headerText(title: "動画一覧")
                ) {
                    ForEach(
                        viewModel.state.videoPrograms.indices,
                        id: \.self
                    ) { index in
                        videoProgramCellView(
                            videoProgram: self.viewModel.state.videoPrograms[index]
                        ).onAppear {
                            self.viewModel.send(.willDisplayVideoProgram(
                                    index: index
                                )
                            )
                        }
                    }
                }
            }
            .listStyle(.grouped)
        }
    }
    
    private func headerText(title: String) -> some View {
        Text(title)
            .fontWeight(.bold)
            .font(Font.system(size: 16))
            .foregroundColor(.black)
            .padding(.leading, 0)
    }
    
    private func videoProgramCellView(videoProgram: VideoProgram) -> some View {
        Text(videoProgram.title)
    }
    
    private func profileInfoCellView() -> some View {
        VStack(
            alignment: .center,
            spacing: 24
        ) {
            Circle()
                .fill(.gray)
                .frame(height: 100)
            Text("ユーザー名")
                .font(.system(size: 16))
                .fontWeight(.bold)
            liveActionInfoView()
            HStack {
                labelButton(title: "フォロー")
                    .onTapGesture {
                        viewModel.send(.didTapFollow)
                    }
                labelButton(title: "お知らせ")
                    .onTapGesture {
                        viewModel.send(.didTapNotification)
                    }
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.vertical, 16)
    }
    
    private func liveActionInfoView() -> some View {
        HStack {
            liveActionCountView(title: "スキル1", count: 100)
            Divider()
            liveActionCountView(title: "スキル2", count: 100)
            Divider()
            liveActionCountView(title: "スキル3", count: 100)
        }
        .frame(height: 40)
    }
    
    private func liveActionCountView(
        title: String,
        count: Int
    ) -> some View {
        VStack {
            Text(title)
                .font(.system(size: 14))
            Text(count.description)
                .font(.system(size: 14))
        }
    }
    
    private func labelButton(title: String) -> some View {
        Label(title, systemImage: "folder.badge.plus")
            .frame(height: 44)
            .frame(maxWidth: .infinity)
            .background(.yellow)
            .cornerRadius(.infinity)
    }
}
