//
//  ExhibitBubble.swift
//  MuseumApp
//
//  Created by Sarah Yoon on 5/22/25.
//

import SwiftUI


// displays view as a circular image
struct ExhibitBubble: View {
    // exhibit stored into an optional
    let exhibit: Exhibit?

    var body: some View {
        // checks if exhibit is nil or not
        if let exhibit = exhibit {
            VStack {
                // loads the exhibit into a circle
                AsyncImage(url: URL(string: exhibit.imageURL)) { image in
                    image
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                } placeholder: {
                    // progress spins while the image loads
                    ProgressView()
                        .frame(width: 80, height: 80)
                }

                // shows the exhibit title
                Text(exhibit.title)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .frame(width: 80)
            }
        } else {
            // exhibit is nil and a placeholder is shown
            Color.clear.frame(width: 80, height: 100)
        }
    }
}

