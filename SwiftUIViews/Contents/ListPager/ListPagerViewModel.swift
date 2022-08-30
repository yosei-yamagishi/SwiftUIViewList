import Combine

class ListPagerViewModel: ObservableObject, UDFViewModel {
    struct State: Equatable {
        static let limitOffset: Int = 20
        static let maxVideoProgramCount = 100
        var videoPrograms = [VideoProgram](
            repeating: VideoProgram(title: "タイトル"),
            count: limitOffset
        )
        
        var isEnableMoreFetchVideoPrograms: Bool {
            videoPrograms.count < Self.maxVideoProgramCount
        }
    }
    
    enum Action {
        case willDisplayVideoProgram(index: Int)
        case didTapFollow
        case didTapNotification
    }
    
    @Published private(set) var state: State
    
    init(state: State = State()) {
        self.state = state
    }
    
    func send(_ action: Action) {
        switch action {
        case let .willDisplayVideoProgram(index):
            if index == state.videoPrograms.count - 1 {
                fetchVideoPrograms()
            }
        case .didTapFollow:
            follow()
        case .didTapNotification:
            confirmNotification()
        }
    }

    private func fetchVideoPrograms() {
        if !state.isEnableMoreFetchVideoPrograms { return }
        let title = "タイトル(page\(state.videoPrograms.count / State.limitOffset))"
        let addedVideos = [VideoProgram](
            repeating: VideoProgram( title: title),
            count: State.limitOffset
        )
        state.videoPrograms.append(contentsOf: addedVideos)
    }
    
    private func follow() {
        print("フォロー")
    }
    
    private func confirmNotification() {
        print("お知らせ")
    }
}
