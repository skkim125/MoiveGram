//
//  TMDBManager.swift
//  MoiveGram
//
//  Created by 김상규 on 6/24/24.
//

import Foundation
import Alamofire

final class TMDBManager {
    static let shared = TMDBManager()
    
    private init() { }
    
    func callRequestAfTMDB<T: Decodable>(api: TMDBAPIRequest, type: T.Type, completionHandler: @escaping (T?) -> ()) {
        AF.request(api.fullURL, parameters: api.parameter, headers: api.headers).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                
                completionHandler(value)
                
            case.failure(let error):
                print("\(error)")
            }
        }
    }
}
