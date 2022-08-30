import Combine

class HomeViewModel: UDFViewModel {
    struct State: Equatable {
        let listTypes: [ListType] = ListType.allCases
    }
    
    enum Action {}
    
    enum ListType: Int, CaseIterable {
        case listPager
        
        var title: String {
            switch self {
            case .listPager: return "リストViewのぺージャー"
            }
        }
        
        var description: String {
            switch self {
            case .listPager: return "リストViewの最後の要素が表示された時に次の要素が読み込まれるView"
            }
        }
    }
    
    @Published private(set) var state: State
    
    init(state: State = State()) {
        self.state = state
    }
    
    func send(_ action: Action) {}
}
