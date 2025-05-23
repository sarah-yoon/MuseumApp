//
//  ExhibitListView.swift
//  MuseumApp
//
//  Created by Sarah Yoon on 5/22/25.
//

import SwiftUI


// shows a list of exhibits based on that was selected by the user
struct ExhibitListView: View {
    // categories the user selected
    let selectedCategories: [String]
    // view model to load and store the exhibits' data
    @StateObject private var viewModel = ExhibitView()
    
    var body: some View {
        VStack {
            
            // list of exhibits based on the data given to the view model
            List(viewModel.exhibits) { exhibit in
                HStack(alignment: .top) {
                    // shows image and details for each exhibit
                    AsyncImage(url: URL(string: exhibit.imageURL)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .cornerRadius(8)
                    } placeholder: {
                        // shows a spinner while loading
                        ProgressView()
                            .frame(width: 100, height: 100)
                    }
                    
                    // exhibit information: title, category, description
                    VStack(alignment: .leading, spacing: 6) {
                        Text(exhibit.title)
                            .font(.headline)
                        Text(exhibit.category)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(exhibit.description)
                            .font(.caption)
                            .lineLimit(3)
                            .foregroundColor(.gray)
                        
                    }
                    
                    
                }
                .padding(.vertical, 8)
            }
            // navigation bar title
            .navigationTitle("Your Tour")
            .task {
                await viewModel.fetchExhibits(for: selectedCategories)
            }
            
            // button to navigate to the tour
            NavigationLink(
                destination: TourPathView(exhibits: viewModel.exhibits),
                label: {
                    Label("Start Guide", systemImage: "figure.walk")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            )
            .padding(.bottom)
        }
    }
}


//#Preview {
//    ExhibitListView()
//}
