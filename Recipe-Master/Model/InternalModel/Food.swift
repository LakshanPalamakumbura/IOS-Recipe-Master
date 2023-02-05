//
//  Food.swift
//  Receipie App
//
//  Created by Lakshan Palamakumbura on 2023-01-27.
//

 import Foundation

 // MARK: - Element
 struct Response: Codable {
     let id: Int
     let name, ingredients, status: String
     let type: TypeEnum
     let image: String?
     let created_at, updated_at: String?

 }


 enum TypeEnum: String, Codable {
     case breakfast = "Breakfast"
     case dessert = "Dessert"
     case mainDish = "Main Dish"
 }
  
/*
 {
 "created_at" = "2023-01-26T17:21:42.000000Z";
 id = 2;
 image = "https://www.google.com/imgres?imgurl=https%3A%2F%2Fi0.wp.com%2Fwww.lavenderandlovage.com%2Fwp-content%2Fuploads%2F2016%2F05%2FEgg-Hoppers.jpg%3Ffit%3D1200%252C1037%26ssl%3D1&imgrefurl=https%3A%2F%2Fwww.lavenderandlovage.com%2Frecipe%2Fegg-hoppers&tbnid=FW1J80C46uD3xM&vet=12ahUKEwiOtLz0gM78AhUQjtgFHZ-iBVoQMygIegUIARD4AQ..i&docid=WbG33zwqOkvpDM&w=1200&h=1037&q=Egg%20Hoppers&client=safari&ved=2ahUKEwiOtLz0gM78AhUQjtgFHZ-iBVoQMygIegUIARD4AQ";
 ingredients = "12 cups rice flour,2 cup granulated sugar,1/2 cups coconut milk,3/4 cup water, tablespoon dry active yeast,1 1/2 teaspoons warm water,1 teaspoon sugar,3/4 cup cooked basmati rice,1 1/2 cups coconut milk,fresh eggs";
 name = "Egg Hoppers";
 status = "calories 310, protein included food";
 type = Breakfast;
 "updated_at" = "2023-01-26T17:21:42.000000Z";
},
 */
