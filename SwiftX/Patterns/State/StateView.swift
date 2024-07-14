import SwiftUI

protocol StateViewPresnting {
    var count: Int { get }
    var toggleValue: Bool { get set }
    func increment()
}

@Observable final class StateViewPresenter: StateViewPresnting {
    var count: Int = 0
    var toggleValue: Bool = false
    func increment() {
        count += 1
    }
}

struct StateView: View {
    @State var presenter: StateViewPresnting = StateViewFactory.presenter
    
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

enum StateViewFactory {
    static var presenter: StateViewPresenter { StateViewPresenter() }
}
