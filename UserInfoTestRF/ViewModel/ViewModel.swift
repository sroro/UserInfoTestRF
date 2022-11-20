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
    
    var updateUI: ((_ uiUpdate: [Results]?) -> Void)?
    var updateName: ((_ nameUpdate: String?) -> Void)?
    
    
    func getUserInfos() {
        network.getUser { [weak self] resultat in
            switch resultat {
            case.failure(_):
                print("error data")
            case.success(let results):
                //sorted array by name ascending
                var arraySorted = results.results.sorted(by: {$0.name.last < $1.name.last})
                self?.updateUI?(arraySorted)
                
                for data in results.results {
                    self?.updateName?(data.name.last)
                }
                
            }
        }
    }
    
}
 

