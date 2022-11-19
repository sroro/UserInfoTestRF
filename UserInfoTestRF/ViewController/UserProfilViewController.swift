//
//  UserProfilViewController.swift
//  UserInfoTestRF
//
//  Created by Rodolphe Schnetzer on 14/11/2022.
//

import UIKit
import MapKit
import SDWebImage

class UserProfilViewController: UIViewController {


    
    //MARK: - IBOutlets
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var imageGender: UIImageView!
    @IBOutlet weak var userIdentity: UILabel!
    
    @IBOutlet weak var pseudoUser: UILabel!
    @IBOutlet weak var mailUser: UILabel!
    @IBOutlet weak var passwordUser: UILabel!
    @IBOutlet weak var ageUser: UILabel!
 
    @IBOutlet weak var streetUser: UILabel!
    @IBOutlet weak var phoneUser: UILabel!
    @IBOutlet weak var countryUser: UILabel!
    @IBOutlet weak var cityUser: UILabel!

    
    //MARK: -viewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        userName()
        addInfoUsers()
        adressInfoUser()
        locationMapUser()
        updateView()
        
    }
   
    //MARK: - Outlets
    
    var longitude: String?
    var userInfos: Results?
    var placeAnnotation: MKAnnotation?
    
    
    //MARK: - Methods
    
    func adressInfoUser() {
        guard let numberStreet = userInfos?.location.street.number else {return}
        guard let street = userInfos?.location.street.name else {return }
        guard let city = userInfos?.location.city else { return }
        guard let country = userInfos?.location.country else { return }

        streetUser.text = String(numberStreet) + " " + street
        cityUser.text = "Ville: \(city)"
        countryUser.text =  country.uppercased()
        
        
    }
    
    func locationMapUser() {
        guard let latitude =  userInfos?.location.coordinates.latitude else { return }
        guard let  longitude =  userInfos?.location.coordinates.longitude else { return }
        
        let convertLatitude = Double(latitude)
        let convertLongitude = Double(longitude)
        //set zoom on position user adress
        let latDelta:CLLocationDegrees = 0.1
        let lonDelta:CLLocationDegrees = 0.1
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let location = CLLocationCoordinate2D(latitude: convertLatitude!, longitude: convertLongitude!)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        
        //add annotation on map
        placeAnnotation = PlaceAnnotation(title: "Adress", coordinate: CLLocationCoordinate2D(latitude: convertLatitude!, longitude: convertLongitude!))
        map.addAnnotation(placeAnnotation!)
    }
    
    func addInfoUsers() {
        guard let imageString = userInfos?.picture.large else { return }
        guard let imageURL = URL(string: imageString) else { return }
        imageUser.sd_setImage(with: imageURL)
        pseudoUser.text = userInfos?.login.username
        mailUser.text = userInfos?.email
        passwordUser.text = userInfos?.login.password
        ageUser.text = "\(userInfos?.dob.age ?? 0) ans"
        phoneUser.text = userInfos?.phone
    }
    
    func userName() {
        guard let gender = userInfos?.gender else { return }
        guard let title = userInfos?.name.title else { return }
        guard let firstname = userInfos?.name.first else { return }
        guard let lastname = userInfos?.name.last else { return }
        
        userIdentity.text = title + " " + firstname + " " + lastname.uppercased()
        
        if gender == "female" {
            imageGender.image = UIImage(named: "female")
        } else if gender == "male" {
            imageGender.image = UIImage(named: "male")
        }
    }
    
    func updateView() {
        whiteView.layer.cornerRadius = 30
        imageUser.layer.cornerRadius = 20
        map.layer.cornerRadius = 20
    
    }
    
    
}


