import Combine
import SwiftUI

protocol ModelPublisherPresenting {
    var modelPublisher: CurrentValueSubject<ModelPublisherView.Model, Never> { get }
    func increment()
}

final class ModelPublisherPresenter: ModelPublisherPresenting {
    
    var toggleValue: Bool = false
    var modelPublisher: CurrentValueSubject<ModelPublisherView.Model, Never> = .init(.empty)
    
    init() {
        self.modelPublisher.send(.init(count: 0, toggleBinding: toggleBinding))
    }
    
    func increment() {
        var model = modelPublisher.value
        model.count += 1
        // I have no idea why toggleBinding needs to be again, but without this line the UI will be incorrect
        model.toggleBinding = toggleBinding
        modelPublisher.send(model)
    }
    
    var toggleBinding: Binding<Bool> {
        .init { [unowned self] in
            self.toggleValue
        } set: { newValue in
            self.toggleValue = newValue
        }
    }
}

struct ModelPublisherView: View {
    
    struct Model {
        var count: Int
        var toggleBinding: Binding<Bool>
        
        static var empty: Self { .init(count: 0, toggleBinding: .constant(false))}
    }
    
    // The presenter also needs to be @State to prevent it being replaced on a parent redraw
    @State var presenter: ModelPublisherPresenting = ModelPublisherFactory.presenter
    @State private var model: Model = .empty
    
    var body: some View {
        VStack {
            Button(action: presenter.increment) {
                Text("Increment Count: \(model.count)")
            }
            Toggle(isOn: model.toggleBinding) {
                Text("Binding Toggle")
            }
        }
        .padding(.horizontal, 24)
        .onReceive(presenter.modelPublisher) { model =  $0}
    }
}

enum ModelPublisherFactory {
    static var presenter: ModelPublisherPresenting { ModelPublisherPresenter() }
}
