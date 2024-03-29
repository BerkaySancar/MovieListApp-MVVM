//
//  ServiceManager.swift
//  MovieListApp
//
//  Created by Berkay Sancar on 12.08.2022.
//

import Alamofire

final class ServiceManager {
    
    static let shared = ServiceManager()
}

extension ServiceManager {
    
    func sendRequest<T: Codable>(url: String, success: @escaping (T) -> Void, failure: @escaping (AFError) -> Void) {
        AF.request(url, encoding: JSONEncoding.default).validate().responseDecodable(of: T.self) { response in
            guard let data = response.value else {
                print(response.error as Any)
                if let error = response.error {
                    failure(error)
                }
                return
            }
            success(data)
        }
    }
}
