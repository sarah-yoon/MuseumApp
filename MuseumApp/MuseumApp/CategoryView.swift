//
//  CategoryView.swift
//  MuseumApp
//
//  Created by Sarah Yoon on 5/22/25.
//

import SwiftUI

struct CategoryView: View {
    @State private var selectedCategories: Set<String> = []
    @State private var navigateToExhibits = false  // ← NEW
    
    let categories = [
        "Post-Impressionism",
        "Surrealism",
        "Renaissance",
        "Pop Art",
        "Abstract"
    ]
    
    var body: some View {
        
        VStack(spacing: 24) {
            Label("Select Your Favorite Art Styles", systemImage: "paintbrush.pointed")
                .font(.title2)
                .padding(.top)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: 16)], spacing: 16) {
                ForEach(categories, id: \.self) { category in
                    Button(action: {
                        toggleCategory(category)
                    }) {
                        Text(category)
                            .fontWeight(.semibold)
                            .foregroundColor(selectedCategories.contains(category) ? .white : .purple)
                            .padding()
                            .frame(width: 170, height: 100)
                            .background(selectedCategories.contains(category) ? Color.purple : Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            NavigationLink(
                destination: ExhibitListView(selectedCategories: Array(selectedCategories)),
                isActive: $navigateToExhibits
            ) {
                EmptyView()
            }
            
            Button(action: {
                navigateToExhibits = true
            }) {
                Label("See My Tour", systemImage: "arrow.right.circle.fill")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300)
                    .background(selectedCategories.isEmpty ? Color.gray : Color.purple)
                    .cornerRadius(10)
            }
            .disabled(selectedCategories.isEmpty)
            
            Spacer()
        }
        .navigationTitle("Choose Interests")
    }
    
    private func toggleCategory(_ category: String) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }
}


#Preview {
    CategoryView()
}
