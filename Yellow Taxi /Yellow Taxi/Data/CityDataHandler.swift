//
//  CityDataHandler.swift
//  Yellow Taxi
//
//  Created by Mayank Arya on 2021-04-02.
//

import Foundation
class AttractionFileHandler{
    var cityDetails : CityDetailsModel?
    let userDefaults = YellowTaxiUserDefaults()
    
    func generateFileUrl() -> URL {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = URL(fileURLWithPath: "CityDataFile", relativeTo: directoryURL).appendingPathExtension("json")
    return fileURL
    }
    
    func getCityData() -> CityDetailsModel{

        let fileURL = generateFileUrl()
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: fileURL.path){
            cityDetails = readData(fileURL: fileURL)
        }else{
            print("File doesn't exist")
            setupInitialJSON(fileURL: fileURL)
        }
    return cityDetails!
    }
    
    func setupInitialJSON(fileURL : URL)  {
        let cityDetailsData = "{\"destination\":[{\"name\":\"Statue Of Liberty\",\"address\":\"New York, NY 10004, United States\",\"phone\":\"2123633200\",\"website\":\"https://www.nps.gov/stli/index.htm\",\"picMain\":\"destination1\",\"extraPics1\":\"destination1_1\",\"extraPics2\":\"destination1_2\",\"extraPics3\":\"destination1_3\",\"extraPics4\":\"destination1_4\",\"destinationDescription\":\"The Statue of Liberty Enlightening the World was a gift of friendship from the people of France to the United States and is recognized as a universal symbol of freedom and democracy. The Statue of Liberty was dedicated on October 28, 1886.  It was designated as a National Monument in 1924.  Employees of the National Park Service have been caring for the colossal copper statue since 1933.\",\"price\":12,\"ratingUser1\":0,\"ratingUser2\":0,\"wishlistUser1\":false,\"wishlistUser2\":false},{\"name\":\"Central Park\",\"address\":\"Manhattan, New York City, United States\",\"phone\":\"2123106600\",\"website\":\"https://www.centralparknyc.org/\",\"picMain\":\"destination2\",\"extraPics1\":\"destination2_1\",\"extraPics2\":\"destination2_2\",\"extraPics3\":\"destination2_3\",\"extraPics4\":\"destination2_4\",\"destinationDescription\":\"Central Park, largest and most important public park in Manhattan, New York City. It occupies an area of 840 acres (340 hectares) and extends between 59th and 110th streets (about 2.5 miles [4 km]) and between Fifth and Eighth avenues (about 0.5 miles [0.8 km]). It was one of the first American parks to be developed using landscape architecture techniques.\",\"price\":0,\"ratingUser1\": 0,\"ratingUser2\": 0,\"wishlistUser1\":false,\"wishlistUser2\":false},{\"name\":\"Rockefeller Center\",\"address\":\"45, Rockefeller Plaza, New York, NY 10111, United States\",\"phone\":\"2125888601\",\"website\":\"https://www.rockefellercenter.com/\",\"picMain\":\"destination3\",\"extraPics1\":\"destination3_1\",\"extraPics2\":\"destination3_2\",\"extraPics3\":\"destination3_3\",\"extraPics4\":\"destination3_4\",\"destinationDescription\":\"Located in the heart of Midtown, Rockefeller Center is an Art Deco complex composed of 19 grand buildings. It's home to a network of businesses, television studios, shopping and dining choices as well as stunning artwork and architecture.\",\"price\":25,\"ratingUser1\":0,\"ratingUser2\":0,\"wishlistUser1\":false,\"wishlistUser2\":false},{\"name\":\"The Metropolitian Museum of Art\",\"address\":\"1000, 5th Ave, New York, NY 10028, United States\",\"phone\":\"2125357710\",\"website\":\"https://www.metmuseum.org/\",\"picMain\":\"destination4\",\"extraPics1\":\"destination4_1\",\"extraPics2\":\"destination4_2\",\"extraPics3\":\"destination4_3\",\"extraPics4\":\"destination4_4\",\"destinationDescription\":\"The Metropolitan Museum of Art collects, studies, conserves, and presents significant works of art across all times and cultures in order to connect people to creativity, knowledge, and ideas.\",\"price\":12,\"ratingUser1\":0,\"ratingUser2\":0,\"wishlistUser1\":false,\"wishlistUser2\":false},{\"name\":\"Times Square\",\"address\":\"Manhattan, NY 10036, United States\",\"phone\":\"0\",\"website\":\"https://www.timessquarenyc.org/\",\"picMain\":\"destination5\",\"extraPics1\":\"destination5_1\",\"extraPics2\":\"destination5_2\",\"extraPics3\":\"destination5_3\",\"extraPics4\":\"destination5_4\",\"destinationDescription\":\"Times Square is a major commercial intersection, tourist destination, entertainment center, and neighborhood in the Midtown Manhattan section of New York City, at the junction of Broadway and Seventh Avenue. Brightly lit by numerous billboards and advertisements, it stretches from West 42nd to West 47th Streets, and is sometimes referred to as the Crossroads of the World, the Center of the Universe, the heart of the Great White Way and the heart of the world\",\"price\":5 ,\"ratingUser1\":0,\"ratingUser2\":0,\"wishlistUser1\":false,\"wishlistUser2\":false}]}"
        
        guard let data = cityDetailsData.data(using: .utf8) else {
            print("Unable to convert string to data")
            return
        }
        do {
         try data.write(to: fileURL)
            cityDetails = readData(fileURL: fileURL)
        } catch {
         print(error.localizedDescription)
        }
        
        
    }

    func getDestinationDetailData(index : Int) -> Destination{
        let fileURL = generateFileUrl()
        let cityDetailData = readData(fileURL: fileURL)
        return (cityDetailData.destination[index])
    }
    
    func readData(fileURL : URL) -> CityDetailsModel{
        do {
         let savedData = try String(contentsOf: fileURL)
            let jsonData = savedData.data(using: .utf8)!
            cityDetails = try! JSONDecoder().decode(CityDetailsModel.self, from:jsonData)
        } catch {
         print("Unable to read the file")
        }
        return cityDetails!
    }
    
    func updateData(fileURL : URL,updatedData : CityDetailsModel){
        do{
            
            let encodedData = try JSONEncoder().encode(updatedData)
            let jsonString = String(data: encodedData,
                                    encoding: .utf8)
            guard let data = jsonString!.data(using: .utf8) else {
                print("Unable to convert string to data")
                return
            }
            do {
             try data.write(to: fileURL)
             print("File saved: updated \(fileURL.absoluteURL)")
            } catch {
             print(error.localizedDescription)
            }
        }catch{
          print("error")
        }
    }
    
    func updateWishlist(index : Int, cityDetails : CityDetailsModel){
        var destination : Destination?
        var cityDetailsNewSet = cityDetails
        var DestinationDataSet : [Destination] = []
        for i in 0...4 {
            let name = cityDetails.destination[i].name
            let address = cityDetails.destination[i].address
            let phone = cityDetails.destination[i].phone
            let website = cityDetails.destination[i].website
            let picMain = cityDetails.destination[i].picMain
            let extraPics1 = cityDetails.destination[i].extraPics1
            let extraPics2 = cityDetails.destination[i].extraPics2
            let extraPics3 = cityDetails.destination[i].extraPics3
            let extraPics4 = cityDetails.destination[i].extraPics4
            let destinationDescription = cityDetails.destination[i].destinationDescription
            let price = cityDetails.destination[i].price
            let ratingUser1 = cityDetails.destination[i].ratingUser1
            let ratingUser2 = cityDetails.destination[i].ratingUser2
            var wishlistUser1  = cityDetails.destination[i].wishlistUser1
            var wishlistUser2  = cityDetails.destination[i].wishlistUser2
            
            if(i == index){
                        if(userDefaults.getLoggedInUser() == "thanos@gmail.com"){
                            let userWishlist = cityDetails.destination[index].wishlistUser1
                            if(userWishlist == true){
                                 wishlistUser1  = false
                            }else{
                                wishlistUser1  = true
                            }
                
                        }else{
                            let userWishlist = cityDetails.destination[index].wishlistUser2
                            if(userWishlist == true){
                                wishlistUser2  = false
                            }else{
                                wishlistUser2  = true
                            }
                        }
                destination = Destination(name: name, address: address, phone: phone, website: website, picMain: picMain, extraPics1: extraPics1, extraPics2: extraPics2, extraPics3: extraPics3, extraPics4: extraPics4, destinationDescription: destinationDescription, price: price, ratingUser1: ratingUser1, ratingUser2: ratingUser2, wishlistUser1: wishlistUser1, wishlistUser2: wishlistUser2)
            }else{
                destination = Destination(name: name, address: address, phone: phone, website: website, picMain: picMain, extraPics1: extraPics1, extraPics2: extraPics2, extraPics3: extraPics3, extraPics4: extraPics4, destinationDescription: destinationDescription, price: price, ratingUser1: ratingUser1, ratingUser2: ratingUser2, wishlistUser1: wishlistUser1, wishlistUser2: wishlistUser2)
            }
            DestinationDataSet.append(destination!)
        }
        let fileURL = generateFileUrl()
        cityDetailsNewSet.destination = DestinationDataSet
        updateData(fileURL: fileURL, updatedData : cityDetailsNewSet)
    }
    

    func updateRating(index : Int, cityDetails : CityDetailsModel,userRating : Double){
        var destination : Destination?
        var cityDetailsNewSet = cityDetails
        var DestinationDataSet : [Destination] = []
        for i in 0...4 {
            let name = cityDetails.destination[i].name
            let address = cityDetails.destination[i].address
            let phone = cityDetails.destination[i].phone
            let website = cityDetails.destination[i].website
            let picMain = cityDetails.destination[i].picMain
            let extraPics1 = cityDetails.destination[i].extraPics1
            let extraPics2 = cityDetails.destination[i].extraPics2
            let extraPics3 = cityDetails.destination[i].extraPics3
            let extraPics4 = cityDetails.destination[i].extraPics4
            let destinationDescription = cityDetails.destination[i].destinationDescription
            let price = cityDetails.destination[i].price
            var ratingUser1 = cityDetails.destination[i].ratingUser1
            var ratingUser2 = cityDetails.destination[i].ratingUser2
            let wishlistUser1  = cityDetails.destination[i].wishlistUser1
            let wishlistUser2  = cityDetails.destination[i].wishlistUser2
            
            if(i == index){
                        if(userDefaults.getLoggedInUser() == "thanos@gmail.com"){
                            ratingUser1 = userRating
                
                        }else{
                            ratingUser2 = userRating
                            print("User 2 rating \(ratingUser2)")
                        }
                destination = Destination(name: name, address: address, phone: phone, website: website, picMain: picMain, extraPics1: extraPics1, extraPics2: extraPics2, extraPics3: extraPics3, extraPics4: extraPics4, destinationDescription: destinationDescription, price: price, ratingUser1: ratingUser1, ratingUser2: ratingUser2, wishlistUser1: wishlistUser1, wishlistUser2: wishlistUser2)
            }else{
                destination = Destination(name: name, address: address, phone: phone, website: website, picMain: picMain, extraPics1: extraPics1, extraPics2: extraPics2, extraPics3: extraPics3, extraPics4: extraPics4, destinationDescription: destinationDescription, price: price, ratingUser1: ratingUser1, ratingUser2: ratingUser2, wishlistUser1: wishlistUser1, wishlistUser2: wishlistUser2)
            }
            DestinationDataSet.append(destination!)
            
        }

        let fileURL = generateFileUrl()
        cityDetailsNewSet.destination = DestinationDataSet
        updateData(fileURL: fileURL, updatedData : cityDetailsNewSet)
    }
}


