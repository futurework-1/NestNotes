//
//  NoteMainView.swift
//  NestNotes
//
//  Created by Адам Табиев on 03.07.2025.
//

import SwiftUI

struct NoteMainView: View {
    var body: some View {
        ZStack {
            Image("Bg_v2")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
        }
    }
}

#Preview {
    NoteMainView()
}
