//  Created by Alexander Skorulis on 13/7/2024.

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                ForEach(Pattern.allCases) { pattern in
                    NavigationLink(pattern.rawValue, value: pattern)
                }
            }
            .navigationTitle("SwiftX")
            .navigationDestination(for: Pattern.self) { pattern in
                PatternContainerView(pattern: pattern)
                    .navigationTitle(pattern.rawValue)
            }
        }
    }
}

#Preview {
    ContentView()
}
