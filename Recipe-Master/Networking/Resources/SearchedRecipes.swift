//
//  searchRecipeObject.swift
//  Food and Recipe
//
//  Created by Lakshan Palamakumbura on 2022-12-14.
//

import Foundation

struct SearchedRecipes: Codable {
    let id: Int
    let title: String
    let image: String
    let imageType: String
}
