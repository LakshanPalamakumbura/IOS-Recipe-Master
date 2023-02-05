//
//  searchResultResponse.swift
//  Food and Recipe
//
//  Created by Lakshan Palamakumbura on 2022-12-14.
//

import Foundation

struct SearchResultResponse: Codable {
    let offset: Int
    let number: Int
    let totalResults: Int
    let results: [SearchedRecipes]
}
