//
//  CircularProgressView.swift
//  BestAppEver
//
//  Created by Student04 on 07/11/2023.
//

import SwiftUI

struct CircularProgressView: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: colorScheme == .light ? .black : .white))
                Spacer()
            }
            Spacer()
        }
    }
}

#Preview {
    CircularProgressView()
}
