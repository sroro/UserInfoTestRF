//
//  ViewModel.swift
//  UserInfoTestRF
//
//  Created by Rodolphe Schnetzer on 17/11/2022.
//

import Foundation

class UserviewModel {
    
    let network = UserNetwork()
    var arrayUsers: [Results]?
    
    var updateUI: ((_ dateUpdate: [Results]?) -> Void)?
    var updateGender: ((_ dateUpdate: String?) -> Void)?
    
    var arrayGender = [String]()
    
    func getUserInfos() {
        network.getUser { [weak self] resultat in
            switch resultat {
            case.failure(_):
                print("error data")
            case.success(let results):
                self?.updateUI?(results.results)
                for data in results.results {
                    self?.updateGender?(data.gender)
                }
                
            }
        }
    }
    
}
 

