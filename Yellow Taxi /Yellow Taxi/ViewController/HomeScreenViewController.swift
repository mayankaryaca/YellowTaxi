//
//  HomeScreenViewController.swift
//  Yellow Taxi
//
//  Created by Mayank Arya on 2021-03-31.
//

import UIKit

class HomeScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CityDelegateProtocol{
  
    func changeWishlist(at indexPath: IndexPath) {
        let cityDetails = AttractionFileHandler().getCityData()
        AttractionFileHandler().updateWishlist( index: indexPath.row, cityDetails: cityDetails)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func setRowItems( cell : CityTableViewCell, rowNumber : Int, cityDetails : CityDetailsModel){
        let user = userDefaults.getLoggedInUser()
        cell.CityNameLabel.text = cityDetails.destination[rowNumber].name
        cell.CityDetailLabel.text = cityDetails.destination[rowNumber].address
        let image = cityDetails.destination[rowNumber].picMain
        cell.CityImageView.image = UIImage(named: image)
        
       
         if(user == "thanos@gmail.com"){
            if(cityDetails.destination[rowNumber].wishlistUser1){
                cell.wishListButton.setImage(UIImage(named: "isSelected"), for: .normal)
                cell.wishListButton.isSelected = true  
            }else{
                cell.wishListButton.setImage(UIImage(named: "isUnselected"), for: .normal)
            }
        }else{
            if(cityDetails.destination[rowNumber].wishlistUser2){
                cell.wishListButton.isSelected = true
                cell.wishListButton.setImage(UIImage(named: "isSelected"), for: .normal )
            }else{
                cell.wishListButton.setImage(UIImage(named: "isUnselected"), for: .normal)
            }
        }
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = CityTableView.dequeueReusableCell(withIdentifier: "cityCell") as? CityTableViewCell
                
        if (cell == nil) {
        cell = CityTableViewCell(
        style: UITableViewCell.CellStyle.default,
        reuseIdentifier: "cityCell")
        }
        
        cell?.cityDelegate = self
        cell?.indexPath = indexPath
        cellVariable = cell!
        
        let cityDetails = AttractionFileHandler().getCityData()
        let sectionNumber = indexPath.section
        if(sectionNumber == 0){
            setRowItems(cell: cell!, rowNumber: indexPath.row, cityDetails: cityDetails)
        }else if(sectionNumber == 1){
            setRowItems(cell: cell!, rowNumber: indexPath.row, cityDetails: cityDetails)
        }else if(sectionNumber == 2){
            setRowItems(cell: cell!, rowNumber: indexPath.row, cityDetails: cityDetails)
        }else if(sectionNumber == 3){
            setRowItems(cell: cell!, rowNumber: indexPath.row, cityDetails: cityDetails)
        }else if (sectionNumber == 4){
            setRowItems(cell: cell!, rowNumber: indexPath.row, cityDetails: cityDetails)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let destinationDetailsVC = storyboard?.instantiateViewController(identifier: "destinationDetails") as? DestinationDetailsViewController else{
            return
        }
        
        destinationDetailsVC.indexOfDestination = indexPath.row
        
        show(destinationDetailsVC, sender: (Any).self)
        
    }
    //MARK : Outlet
    @IBOutlet weak var CityTableView: UITableView!
    
    let userDefaults = YellowTaxiUserDefaults()
    var cellVariable = CityTableViewCell()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK : Navigation Bar
        self.navigationItem.setHidesBackButton(true, animated: true)
        let logOutButton = UIBarButtonItem(image: UIImage(named: ""), style: .plain, target: self, action: #selector(self.logOutUser))
        logOutButton.title = "Log Out"
        logOutButton.tintColor = .systemYellow
        self.navigationItem.rightBarButtonItem  = logOutButton
        self.title = "Attractions List"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemYellow]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.isHidden = false
        
        
        self.CityTableView.delegate = self
        self.CityTableView.dataSource = self
        self.CityTableView.rowHeight = 110
    }
    
    @objc func logOutUser(){
        userDefaults.userLogOut()
        guard let loginScreenVc = self.storyboard?.instantiateViewController(identifier: "LoginScreen") as? LoginViewController else{
            return
        }
        self.show(loginScreenVc, sender: (Any).self)
        
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
