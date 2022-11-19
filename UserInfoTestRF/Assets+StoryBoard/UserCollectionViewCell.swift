//
//  UserCollectionViewCell.swift
//  UserInfoTestRF
//
//  Created by Rodolphe Schnetzer on 14/11/2022.
//

import UIKit
import SDWebImage

class UserCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    @IBOutlet weak var firstNameUser: UILabel!
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    var userCell: Results?{
        didSet{
            
            guard let stringImage = userCell?.picture.large else { return }
            guard let imageUrl = URL(string: stringImage) else {return}
            userImage.sd_setImage(with: imageUrl)
            firstNameUser.text = userCell?.name.first
            nameUser.text = userCell?.name.last.uppercased()
            userImage.layer.cornerRadius = 20
            viewCell.layer.cornerRadius = 20
     
        }
    }
}




