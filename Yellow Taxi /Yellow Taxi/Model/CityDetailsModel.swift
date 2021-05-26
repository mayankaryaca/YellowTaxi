//
//  CityDetailsModel.swift
//  Yellow Taxi
//
//  Created by Mayank Arya on 2021-03-31.
//

import Foundation

struct CityDetailsModel : Codable {
    var destination : [Destination]
}

// MARK: - Destination
struct Destination: Codable {
    var name : String
    var address : String
    var phone: String
    var website: String
    var picMain : String
    var extraPics1 : String
    var extraPics2 : String
    var extraPics3 : String
    var extraPics4: String
    var destinationDescription: String
    var price: Int
    var ratingUser1 : Double
    var ratingUser2: Double
    var wishlistUser1 : Bool
    var wishlistUser2 : Bool
    
    init( name : String,
     address : String,
     phone: String,
     website: String,
     picMain : String,
     extraPics1 : String,
     extraPics2 : String,
     extraPics3 : String,
     extraPics4: String,
     destinationDescription: String,
     price: Int,
     ratingUser1 : Double,
     ratingUser2: Double,
     wishlistUser1 : Bool,
     wishlistUser2 : Bool){
        self.name = name
        self.address = address
        self.phone = phone
        self.website = website
        self.picMain = picMain
        self.extraPics1 = extraPics1
        self.extraPics2 = extraPics2
        self.extraPics3 = extraPics3
        self.extraPics4 = extraPics4
        self.destinationDescription = destinationDescription
        self.price = price
        self.ratingUser1 = ratingUser1
        self.ratingUser2 = ratingUser2
        self.wishlistUser1 = wishlistUser1
        self.wishlistUser2 = wishlistUser2

        
    }
}

