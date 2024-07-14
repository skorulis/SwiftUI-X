//  Created by Alexander Skorulis on 13/7/2024.

import SwiftUI

// This view has a button which redraws this view and its children.
// Children should maintain their state during redraws
struct PatternContainerView: View {
    
    @State private var uuid: UUID = .init()
    let pattern: Pattern
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                pattern.screen
                
                Button(action: {uuid = .init()}) {
                    Text("Simulate view hierarchy redraw")
                }
                Text(uuid.uuidString)
                    .hidden()
            }
        }
    }
}
