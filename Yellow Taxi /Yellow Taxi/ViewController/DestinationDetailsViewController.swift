//
//  DestinationDetailsViewController.swift
//  Yellow Taxi
//
//  Created by Mayank Arya on 2021-04-04.
//

import UIKit
import Cosmos


class DestinationDetailsViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ImageScrollView.dequeueReusableCell(withReuseIdentifier: "ImageViewCollectionCell", for: indexPath) as? ImageViewCollectionCell
        let sectionNumber = indexPath.row
        if(sectionNumber == 0){
            cell?.destinationImageView.image = UIImage(named : destinationImage1)
        }else if(sectionNumber == 1){
            cell?.destinationImageView.image = UIImage(named : destinationImage2)
        }else if(sectionNumber == 2){
            cell?.destinationImageView.image = UIImage(named : destinationImage3)
        }else if(sectionNumber == 3){
            cell?.destinationImageView.image = UIImage(named : destinationImage4)
        }
        
        return cell!
    }
    
 
    
// MARK :  VC Class variables
    var destination : Destination?
  
    var indexOfDestination : Int?
    
    var destinationImage1 = ""
    var destinationImage2 = ""
    var destinationImage3 = ""
    var destinationImage4 = ""

    @objc func onDismiss(){
        dismiss(animated: false, completion : nil )
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK : Navigation Bar
        let logOutButton = UIBarButtonItem(image: UIImage(named: ""), style: .plain, target: self, action: #selector(self.logOutUser))
        logOutButton.title = "Log Out"
        logOutButton.tintColor = .systemYellow
        self.navigationItem.rightBarButtonItem  = logOutButton
        
        let backButton = UIBarButtonItem(image: UIImage(named: ""), style: .plain, target: self, action: #selector(self.onBackPressed))
        backButton.title = "< Back"
        backButton.tintColor = .systemYellow
        self.navigationItem.leftBarButtonItem  = backButton
        
        self.title = "Destination Details"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemYellow]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.isHidden = false
        
        
        self.ImageScrollView.dataSource = self
        self.ImageScrollView.delegate = self
        
        
        destination = AttractionFileHandler().getDestinationDetailData(index: indexOfDestination!)
        destinationName.text = destination?.name
        destinationDescription.text = destination?.destinationDescription
        destinationWebsite.text = destination?.website
        if(destination?.phone == "0"){
            destinationPhone.text = "Not Available"

        }else{
            destinationPhone.text = "+1 " + destination!.phone
        }
        if(destination?.price == 0){
            destinationPrice.text = "Free Entry"
        }else{
            destinationPrice.text = "$" + String(destination!.price)
        }
        destinationImage1 = destination!.extraPics1
        destinationImage2 = destination!.extraPics2
        destinationImage3 = destination!.extraPics3
        destinationImage4 = destination!.extraPics4
        
        let tapPhone = UITapGestureRecognizer(target: self, action: #selector(DestinationDetailsViewController.onPhoneClick))
            destinationPhone.addGestureRecognizer(tapPhone)
            
        let tapWebsite = UITapGestureRecognizer(target: self, action: #selector(DestinationDetailsViewController.onWebsiteClick))
            destinationWebsite.addGestureRecognizer(tapWebsite)
        
        if(YellowTaxiUserDefaults().getLoggedInUser() == "thanos@gmail.com"){
            ratingBar.rating  = destination!.ratingUser1
        }else{
            ratingBar.rating  = destination!.ratingUser2
        }
        ratingBar.didFinishTouchingCosmos = { rating in
            AttractionFileHandler().updateRating(index: self.indexOfDestination!, cityDetails:  AttractionFileHandler().getCityData(), userRating: rating)
         }
    }
    

    @objc func onPhoneClick(sender: UITapGestureRecognizer) {
     
        let phonenumber = "+1"+destination!.phone
        var uc = URLComponents()
        uc.scheme = "tel"
        uc.path = phonenumber
        
        guard let number = uc.url else {
            print("No working)")
            return }
        if UIApplication.shared.canOpenURL(number) {
            print("phone dial tried...\(number)")
           UIApplication.shared.open(number, options: [:], completionHandler: nil)
        }else{
            print("phone open URL failed.")
        }
   
    }
    
    @objc func onWebsiteClick(sender: UITapGestureRecognizer) {
        let url = URL(string: destinationWebsite.text!)!
           if UIApplication.shared.canOpenURL(url) {
              UIApplication.shared.open(url, options: [:], completionHandler: nil)
           }
    }
    
    @objc func logOutUser(){
        YellowTaxiUserDefaults().userLogOut()
        guard let loginScreenVc = self.storyboard?.instantiateViewController(identifier: "LoginScreen") as? LoginViewController else{
            return
        }
        self.show(loginScreenVc, sender: (Any).self)
        
    }
    
    @objc func onBackPressed(){
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    // MARK : Outlets
    
    @IBOutlet weak var ImageScrollView: UICollectionView!
    
    @IBOutlet weak var destinationName: UILabel!
    
    @IBOutlet weak var destinationDescription: UILabel!
    
    @IBOutlet weak var destinationPrice: UILabel!
    
    @IBOutlet weak var destinationWebsite: UILabel!
    
    @IBOutlet weak var destinationPhone: UILabel!

    @IBOutlet weak var ratingBar: CosmosView!
    

}
