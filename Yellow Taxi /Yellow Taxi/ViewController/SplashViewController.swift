//
//  SplashViewController.swift
//  Yellow Taxi
//
//  Created by Mayank Arya on 2021-04-04.
//

import UIKit

class SplashViewController: UIViewController {

    var userdefaults = YellowTaxiUserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            if(self.userdefaults.doRememberMe()){
                guard let homeScreenVc = self.storyboard?.instantiateViewController(identifier: "HomeScreen") as? HomeScreenViewController else{
                    return
                }
                self.show(homeScreenVc, sender: (Any).self)

            }else{
                guard let loginScreenVc = self.storyboard?.instantiateViewController(identifier: "LoginScreen") as? LoginViewController else{
                    return
                }
                self.show(loginScreenVc, sender: (Any).self)

            }
        }
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
