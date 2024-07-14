//  Created by Alexander Skorulis on 13/7/2024.

import SwiftUI

struct ObservableObjectView: View {
    
    // Reusing the StateObject presenter since the patterns are the same
    // @ObservableObject does not take ownership
    @ObservedObject var presenter: StateObjectPresenter = StateObjectFactory.presenter
    
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
