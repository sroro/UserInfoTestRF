//
//  alert+extension.swift
//  UserInfoTestRF
//
//  Created by Rodolphe Schnetzer on 16/11/2022.
//
import UIKit

extension UIViewController {
    
    func displayAlertNoData(){
        let alert = UIAlertController(title: "No Data", message: "Sorry no data", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
    
}


