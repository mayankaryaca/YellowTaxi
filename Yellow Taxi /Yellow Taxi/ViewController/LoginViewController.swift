//
//  LoginViewController.swift
//  Yellow Taxi
//
//  Created by Mayank Arya on 2021-03-31.
//

import UIKit

class LoginViewController: UIViewController{
    //MARK : User Defaults
    let yTuserDefaults = YellowTaxiUserDefaults()
    var userArrayList : [User] = []
    var isUsernameCheck = false
    var isPasswordCheck = false
    
    // MARK : Outlets
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var userpasswordLabel: UITextField!
    @IBOutlet weak var rememberMeLabel: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        addUserToList()
        userpasswordLabel.isSecureTextEntry = true
        self.navigationController?.navigationBar.isHidden = true
        rememberMeLabel.onTintColor = .systemYellow
        // Do any additional setup after loading the view.
    }
    
    // MARK : functions
    @IBAction func onLoginPressed(_ sender: UIButton) {
        self.isUsernameCheck = false
        self.isPasswordCheck = false
        guard let username = usernameLabel.text , let password = userpasswordLabel.text else{
          print("Error")
            return
        }
        checkLoginDetails(username: username, password: password)
        if(isUsernameCheck == true){
            if(isPasswordCheck == true){
                print("Logged In")
                guard let homeScreenVc = storyboard?.instantiateViewController(identifier: "HomeScreen") as? HomeScreenViewController else{
                    return
                }
                show(homeScreenVc, sender: sender)
            }else{
                let alert = UIAlertController(title: "Login Error!", message: "Password is incorrect", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(
                            title: "OK",
                            style: .default,
                            handler: {
                                (UIAlertAction) in
                                self.userpasswordLabel.text = ""
                            }))

                        self.present(alert, animated: true, completion: nil)
                
            }
        }else{
            let alert = UIAlertController(title: "Login Error!", message: "Username is incorrect", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(
                        title: "OK",
                        style: .default,
                        handler: {
                            (UIAlertAction) in
                            self.usernameLabel.text = ""
                        }))
                    self.present(alert, animated: true, completion: nil)        }
        
    }
    
    func checkLoginDetails(username : String, password : String){
        for i in 0...1{
            let dbUsername = userArrayList[i].username
            let dbPassword = userArrayList[i].password
            let isRememberMe = rememberMeLabel.isOn
            if(dbUsername == username){
                if(dbPassword == password){
                    yTuserDefaults.userLogIn(username: username, password: password, isLoggedIn: isRememberMe)
                    isPasswordCheck.toggle()
                }
                isUsernameCheck.toggle()
            }
        
        }
    }
    
    func addUserToList(){
        let user1 = User(username: "thanos@gmail.com", password: "5555")
        let user2 = User(username: "wonderwoman@yahoo.com", password: "abcd")
        
        userArrayList.append(user1)
        userArrayList.append(user2)
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
