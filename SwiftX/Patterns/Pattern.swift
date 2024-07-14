import SwiftUI

enum Pattern: String, Identifiable, CaseIterable {
    case stateObject = "StateObject"
    case observedObject = "ObservedObject"
    case state = "State (iOS 17)"
    case modelPublisher = "Model Publisher"
    case propertyWrapper = "Property Wrapper"
    case propertyWrapperWithState = "Property Wrapper With State"
    case tca = "The Composable Architecture"
    
    var id: String { rawValue }
}

extension Pattern {
    @ViewBuilder
    var screen: some View {
        switch self {
        case .stateObject:
            StateObjectView()
        case .observedObject:
            ObservedObjectView()
        case .state:
            StateView()
        case .modelPublisher:
            ModelPublisherView()
        case .propertyWrapper:
            PresenterWrapperView()
        case .propertyWrapperWithState:
            PresenterOwningView(presenter: PresenterWrapperFactory.presenter) {
                PresenterWrapperView(presenter: $0)
            }
        case .tca:
            TCAView()
        }
    }
    
    var notes: String {
        switch self {
        case .stateObject:
            return "Standard ViewModel pattern. It does not support using a fake presenter due to the associated type on ObservableObject."
        case .observedObject:
            return "@StateObject was introduced iOS 14.0. @ObservableObject suffers the same issues in addition to the presenter not being owned by view."
        case .state:
            return "@Observable was introduced in iOS 17.0 which allows @State to work with reference types. Solves the fake issue of @StateObject"
        case .modelPublisher:
            return "Publishes data changes via a model object."
        case .propertyWrapper:
            return "Custom property wrapper that imitates @ObservedObject using type erasure. Does not take ownership of the presenter."
        case .propertyWrapperWithState:
            return "Wraps the property wrapper example so that the presenter is owned."
        case .tca:
            return ""
        }
    }
}
