//
//  ViewController.swift
//  UserInfoTestRF
//
//  Created by Rodolphe Schnetzer on 14/11/2022.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "UserCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "userCell")
        collectionView.delegate = self
        
        self.viewModel.updateUI = { [weak self] arrayOfUsers in
            guard let array = arrayOfUsers else { return }
            self?.arrayUsers.append(contentsOf: array)
          
        }
        
        self.viewModel.updateName = { [weak self] arrayNames in
            guard let arrayNamesUnwrap = arrayNames else { return }
            self?.arrayName.append(arrayNamesUnwrap)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
  
            self.viewModel.getUserInfos()
        
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //MARK: -Properties
    
    var arrayUsers = [Results]()
    //arrayGender for set number of User in collectionView
    var arrayName = [String]() {
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                print(self.arrayName.sorted())
            }
        }
    }
    var arrayUserSelected: Results?
    var viewModel = UserviewModel()
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCell", for: indexPath) as? UserCollectionViewCell else { return UICollectionViewCell() }
        cell.userCell = arrayUsers[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        arrayUserSelected = arrayUsers[indexPath.row]
        performSegue(withIdentifier: "segueToProfil", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToProfil" {
            let vcDestination = segue.destination as? UserProfilViewController
            vcDestination?.userInfos = arrayUserSelected
        }
    }
    
    
}

