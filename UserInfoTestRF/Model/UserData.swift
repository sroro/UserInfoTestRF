//  UserInfoTestRF
//
//  Created by Rodolphe Schnetzer on 15/11/2022.
//

import Foundation

// MARK: - UsersData
struct UsersData: Decodable {
    let results: [Results]
}

// MARK: - Result
struct Results: Decodable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let phone, cell: String
    let nat: String
    let age: Int?
    let login: Login
    let id: ID
    let dob, registered: Dob
    let picture: Picture
}

// MARK: - Dob
struct Dob: Decodable {
    let date: String
    let age: Int
}

// MARK: - ID
struct ID: Decodable {
    let name, value: String?
}
//
// MARK: - Location
struct Location: Decodable {
    let street: Street
    let city, state, country: String?
    let coordinates: Coordinates
}
//
// MARK: - Coordinates
struct Coordinates: Decodable {
    let latitude, longitude: String?
}
//
// MARK: - Street
struct Street: Decodable {
    let number: Int
    let name: String
    let postcode: Int?
}
//
//
// MARK: - Login
struct Login: Decodable {
    let username, password: String
}
//
// MARK: - Name
struct Name: Decodable {
    let title, first, last: String
}
//
// MARK: - Picture
struct Picture: Decodable {
    let large, medium, thumbnail: String
}


