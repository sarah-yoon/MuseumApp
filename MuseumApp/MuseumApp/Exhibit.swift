//
//  Exhibit.swift
//  MuseumApp
//
//  Created by Sarah Yoon on 5/22/25.
//

import Foundation

//exhibit object structure
struct Exhibit: Identifiable, Codable, Equatable {
    let id: Int
    let title: String
    let category: String
    let description: String
    let imageURL: String
    let location: String
}
