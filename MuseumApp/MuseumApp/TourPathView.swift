//
//  TourPathView.swift
//  MuseumApp
//
//  Created by Sarah Yoon on 5/22/25.
//

import SwiftUI

// shows the tour path based on the selected categories
struct TourPathView: View {
    
    // list of exhibits selected by the user
    let exhibits: [Exhibit]
    
    
    var body: some View {
        // finds the first exhibit of each location
        let topLeft = exhibits.first { $0.location == "topLeft" }
        let topRight = exhibits.first { $0.location == "topRight" }
        let center = exhibits.first { $0.location == "center" }
        let bottomLeft = exhibits.first { $0.location == "bottomLeft" }
        let bottomRight = exhibits.first { $0.location == "bottomRight" }

        // allows scrolling
        ScrollView {
            
            VStack(spacing: 24) {

                // top row
                HStack(spacing: 0) {
                    // shows the top left exhibit
                    if let bubble = topLeft {
                        ExhibitBubble(exhibit: bubble)
                    } else {
                        // placeholder if there is none
                        Color.clear.frame(width: 100, height: 130)
                    }
                    
                    // line that connects the topLeft and topRight
                    if topLeft != nil && topRight != nil {
                        Rectangle()
                            .fill(Color.purple)
                            .frame(height: 2)
                            .frame(width: 60)
                    } else {
                        Spacer().frame(width: 60)
                    }

                    // shows the top right
                    if let bubble = topRight {
                        // shows the top right exhibit
                        ExhibitBubble(exhibit: bubble)
                    } else {
                        // placeholder if there is none
                        Color.clear.frame(width: 100, height: 130)
                    }
                }

                // line that connects the top row and center
                if (topLeft != nil || topRight != nil) && center != nil {
                    Rectangle()
                        .fill(Color.purple)
                        .frame(width: 2, height: 40)
                }

                // center
                if let centerBubble = center {
                    // shows the center exhibit
                    ExhibitBubble(exhibit: centerBubble)
                        .frame(width: 100, height: 130)
                } else {
                    Color.clear.frame(width: 100, height: 130)
                }

                // line that connects the center and bottom
                if center != nil && (bottomLeft != nil || bottomRight != nil) {
                    Rectangle()
                        .fill(Color.purple)
                        .frame(width: 2, height: 40)
                }

                // bottom row
                HStack(spacing: 0) {
                    // shows the bottom left exhibit
                    if let bubble = bottomLeft {
                        ExhibitBubble(exhibit: bubble)
                    } else {
                        Color.clear.frame(width: 100, height: 130)
                    }

                    // line that connects the bottomLeft and bottomRight
                    if bottomLeft != nil && bottomRight != nil {
                        Rectangle()
                            .fill(Color.purple)
                            .frame(height: 2)
                            .frame(width: 60)
                    } else {
                        Spacer().frame(width: 60)
                    }

                    if let bubble = bottomRight {
                        // shows the bottom right exhibit
                        ExhibitBubble(exhibit: bubble)
                    } else {
                        Color.clear.frame(width: 100, height: 130)
                    }
                }
            }
            .padding()
            .background(
                
                // museum background image
                Image("museummap")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.3)
                    .frame(width: 350, height: 500) // locks the map size
            )
        }
        
        .navigationTitle("Tour Map")
    }
}

// safely indexing into collections
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}


//#Preview {
//    TourPathView()
//}
