// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
import Foundation

// MARK: - Element
struct FavouriteResponse: Codable {
    let id, userID, foodID: Int
    let createdAt, updatedAt: String
    let food: Food

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case foodID = "food_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case food
    }
}

// MARK: - Food
struct Food: Codable {
    let id: Int
    let name, ingredients, status, type: String
    let image, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name, ingredients, status, type, image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

