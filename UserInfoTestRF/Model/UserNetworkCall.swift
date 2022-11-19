//
//  UserNetworkCall.swift
//  UserInfoTestRF
//
//  Created by Rodolphe Schnetzer on 15/11/2022.
//

import Foundation

final class UserNetwork {
    
    enum Errors: Error {
        case noData, noResponse, undecodable
    }
    // MARK: - properties
    
    private let session : URLSession
    private var task: URLSessionDataTask?
    
    // MARK: - initializer
    
    init(session:URLSession = URLSession(configuration: .default)){
        self.session = session
    }
    // MARK: - Methods
    

    func getUser(callback: @escaping (Result <UsersData, Error>) -> Void) {
        
        guard let userAPI = URL(string: "https://randomuser.me/api/?results=50") else { return }
        
        task?.cancel()
        
        task = session.dataTask(with: userAPI) { data, response, error in
            guard let data = data, error == nil else {
                callback(.failure(Errors.noData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(Errors.noResponse))
                return
            }
            
            guard let responseJSON = try? JSONDecoder().decode(UsersData.self, from: data) else {
                        callback(.failure(Errors.undecodable))
                        return
                }
            callback(.success(responseJSON))
            
            
        }
        task?.resume()
        
    }
    
    
}
