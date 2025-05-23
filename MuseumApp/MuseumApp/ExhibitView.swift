//
//  ExhibitView.swift
//  MuseumApp
//
//  Created by Sarah Yoon on 5/22/25.
//

import Foundation
import SwiftUI

@MainActor
class ExhibitView: ObservableObject {
    // array of exhibits that the view ccan observe and update
    @Published var exhibits: [Exhibit] = []
    
    //function that gets exhibit data from a JSON file
    func fetchExhibits(for categories: [String]) async {
        // getting the url from a JSON file
        guard let url = Bundle.main.url(forResource: "Exhibits", withExtension: "json"),
              // decode JSON into an array of exhibits
              let data = try? Data(contentsOf: url) else { return }

        do {
            let allExhibits = try JSONDecoder().decode([Exhibit].self, from: data)
            
            // only includes the categories that were selected
            self.exhibits = allExhibits.filter { categories.contains($0.category) }
        } catch {
            // if it fails, it prints and error
            print("Failed to decode:", error)
        }
    }
}


//#Preview {
//    ExhibitView()
//}
