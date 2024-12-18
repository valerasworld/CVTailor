//
//  FontDemo.swift
//  CVTailor
//
//  Created by Valery Zazulin on 04/12/24.
//

import SwiftUI

struct FontDemo: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Journal")
                .font(.system(.largeTitle, design: .serif)).bold()
        }
        .padding()
    }
}

#Preview {
    FontDemo()
}
