import SwiftUI

protocol StateObjectPresenting: ObservableObject {
    var count: Int { get }
    var toggleValue: Bool { get set }
    func increment()
}

final class StateObjectPresenter: ObservableObject, StateObjectPresenting {
    @Published var count: Int = 0
    @Published var toggleValue: Bool = false
    
    func increment() {
        count += 1
    }
}

struct StateObjectView: View {
    
    // @StateObject takes ownership of the presenter
    @StateObject var presenter: StateObjectPresenter = StateObjectFactory.presenter
    
    var body: some View {
        VStack {
            Button(action: presenter.increment) {
                Text("Increment Count: \(presenter.count)")
            }
            Toggle(isOn: $presenter.toggleValue) {
                Text("Binding Toggle")
            }
        }
        .padding(.horizontal, 24)
    }
}

enum StateObjectFactory {
    static var presenter: StateObjectPresenter { .init() }
}
