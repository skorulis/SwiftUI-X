import SwiftUI

protocol PresenterWrapperPresenting: AnyObservableObject {
    var count: Int { get }
    var toggleValue: Bool { get set }
    func increment()
}

final class PresenterWrapperPresenter: ObservableObject, PresenterWrapperPresenting {
    @Published var count: Int = 0
    @Published var toggleValue: Bool = false
    
    func increment() {
        count += 1
    }
}

struct PresenterWrapperView: View {
    
    @Store var presenter: PresenterWrapperPresenting = PresenterWrapperFactory.presenter
    
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

struct PresenterOwningView<Content: View, Presenter>: View {
    
    @State private var presenter: Presenter
    private let content: (Presenter) -> Content
    
    init(presenter: Presenter, content: @escaping (Presenter) -> Content) {
        _presenter = .init(wrappedValue: presenter)
        self.content = content
    }
    
    var body: some View {
        content(presenter)
    }
}

enum PresenterWrapperFactory {
    static var presenter: PresenterWrapperPresenting { PresenterWrapperPresenter() }
}
