//
//  PlaceAnnotation.swift
//  UserInfoTestRF
//
//  Created by Rodolphe Schnetzer on 16/11/2022.
//

import UIKit
import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(title:String, coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.title = title
      
    }
    
        
}
