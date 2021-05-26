//
//  YellowTaxiUserDefaults.swift
//  Yellow Taxi
//
//  Created by Mayank Arya on 2021-03-31.
//

import UIKit

class YellowTaxiUserDefaults{
    let defaults = UserDefaults.standard
    let keyUsername = "Username"
    let keyPassword = "Password"
    let keyLoggedIn = "isLoggedIn"

    func userLogIn(username : String, password : String, isLoggedIn : Bool){
        defaults.setValue(username, forKey: keyUsername)
        defaults.setValue(password, forKey: keyPassword)
        defaults.setValue(isLoggedIn ,forKey: keyLoggedIn)
    }
    
    func userLogOut(){
        defaults.removeObject(forKey: keyLoggedIn)
        defaults.removeObject(forKey: keyUsername)
        defaults.removeObject(forKey: keyPassword)
    }
    
    func getLoggedInUser() -> String{
        return defaults.string(forKey: keyUsername)!
    }
    
    func doRememberMe() -> Bool{
        return defaults.bool(forKey: keyLoggedIn)
    }
    
    func getUsername() -> String{
        let user = defaults.string(forKey: keyUsername)!
        let nameArray  = user.components(separatedBy: "@")
        let username = nameArray[0]
        return username
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
