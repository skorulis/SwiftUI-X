import ComposableArchitecture
import SwiftUI

struct TCAView: View {
    
    @State var store: StoreOf<TCAReducer> = .init(initialState: .empty, reducer: { TCAReducer() })
    
    var body: some View {
        WithViewStore(self.store, observe: {$0}) { viewStore in
            VStack {
                Button(action: { viewStore.send(.increment) }) {
                    Text("Increment Count: \(viewStore.state.count)")
                }
                Toggle(isOn: viewStore.binding(get: \.toggleValue, send: TCAReducer.Action.toggle)) {
                    Text("Binding Toggle")
                }
            }
            .padding(.horizontal, 24)
        }
    }
}

struct TCAReducer: Reducer {
    struct State: Equatable {
        var count: Int
        var toggleValue: Bool
        
        static var empty: Self { .init(count: 0, toggleValue: false) }
    }
    
    enum Action: Equatable {
        case increment
        case toggle(Bool)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .increment:
                state.count += 1
                return .none
            case let .toggle(value):
                state.toggleValue = value
                return .none
            }
        }
    }
}

enum TCAFactory {
    static var reducer: TCAReducer { TCAReducer() }
}
