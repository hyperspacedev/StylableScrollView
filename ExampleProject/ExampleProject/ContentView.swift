//
//  ContentView.swift
//  ExampleProject
//
//  Created by Marquis Kurt on 23/9/21.
//

import SwiftUI
import StylableScrollView

struct ContentView: View {
    var body: some View {
        StylableScrollView(.vertical, showIndicators: true) {
            VStack(alignment: .leading) {
                ForEach(0..<42) {_ in
                    Text("""
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
""")
                        .padding(.vertical)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .scrollViewStyle(
            StretchableScrollViewStyle(
                header: {
                    Image("ExampleHeader")
                        .resizable()
                },
                title: {
                    HStack(alignment: .bottom) {
                        Text("High Sierras")
                            .bold()
                            .font(.title)
                            .foregroundColor(.white)
                        Spacer()
                        registerButton
                    }
                },
                navBarContent: {
                    HStack(alignment: .bottom) {
                        Text("High Sierras")
                            .bold()
                            .font(.title2)
                        Spacer()
                        registerButton
                    }
                    .padding(.horizontal)

                }
            )
        )
    }
    
    var registerButton: some View {
        Button(action: {print("I'm doing something...")}) {
            Label("Register", systemImage: "square.and.pencil")
                .foregroundColor(.accentColor)
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background(.thinMaterial)
        .cornerRadius(32)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
