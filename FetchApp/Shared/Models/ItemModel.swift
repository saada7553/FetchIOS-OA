//
//  ItemModel.swift
//  FetchApp (iOS)
//
//  Created by Saad Ata on 2/18/23.
//

import Foundation

// Models each entry in the JSON response
struct ItemModel: Identifiable, Codable {
    
    let id: Int
    let listId: Int
    let name: String? // Optional string, it may be null in the response
    
}
