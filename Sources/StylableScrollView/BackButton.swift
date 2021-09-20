//
//  BackButton.swift
//  
//
//  Obtained from https://github.com/nerdsupremacist/FancyScrollView. All credits go to them.
//

import Foundation
import SwiftUI

/// Allows to go to the previous view.
public struct BackButton: View {
    public let color: Color

    @Environment(\.presentationMode)
    public var presentationMode: Binding<PresentationMode>
    
    @State private var hasBeenShownAtLeastOnce: Bool = false

    public var body: some View {
        (presentationMode.wrappedValue.isPresented || hasBeenShownAtLeastOnce) ?
            Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
               Image(systemName: "chevron.left")
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(height: 20, alignment: .leading)
                   .foregroundColor(color)
                   .padding(.horizontal, 16)
                   .font(Font.body.bold())
            }
            .onAppear {
                self.hasBeenShownAtLeastOnce = true
            }
        : nil
    }
}
