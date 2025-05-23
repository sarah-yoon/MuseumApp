//
//  ContentView.swift
//  MuseumApp
//
//  Created by Sarah Yoon on 5/22/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                
                // welcome text placed in the middle
                Text("Welcome to your tour!")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Let's plan your visit!")
                    .font(.body)
                    .foregroundColor(.gray)

                //start tour button that goes to a list of categories
                NavigationLink(destination: CategoryView()) {
                    Label("Start Tour", systemImage: "map")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300)
                        .background(Color.purple)
                        .cornerRadius(10)
                }

                Spacer()
                //art quiz button that goes to art quiz
                NavigationLink(destination: ArtQuizView()) {
                    Label("Test Your Art Knowledge", systemImage: "paintpalette")
                        .font(.subheadline)
                        .foregroundColor(.purple)
                }
            }
            .navigationTitle("Art Museum Tour")
        }
    }
}


#Preview {
    ContentView()
}
