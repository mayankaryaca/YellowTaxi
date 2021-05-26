//
//  CityTableViewCell.swift
//  Yellow Taxi
//
//  Created by Mayank Arya on 2021-03-31.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var CityImageView: UIImageView!
    @IBOutlet weak var CityNameLabel: UILabel!
    @IBOutlet weak var CityDetailLabel: UILabel!
    @IBOutlet weak var wishListButton: UIButton!
    
    var cityDelegate : CityDelegateProtocol?
    var indexPath : IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func wishlistButtonPressed(_ sender: UIButton) {
        self.cityDelegate?.changeWishlist(at: indexPath)
        if(wishListButton.isSelected){
            wishListButton.isSelected = false
            wishListButton.setImage(UIImage(named: "isUnselected"), for: .normal)
        }else{
            wishListButton.isSelected = true
            wishListButton.setImage(UIImage(named: "isSelected"), for: .normal)

        }

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
   
        // Configure the view for the selected state
    }

}

protocol CityDelegateProtocol {
    func changeWishlist(at indexPath : IndexPath)
}
