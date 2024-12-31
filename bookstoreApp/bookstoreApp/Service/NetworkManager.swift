//
//  NetworkManager.swift
//  bookstoreApp
//
//  Created by jae hoon lee on 12/30/24.
//

import UIKit
import Alamofire
import RxSwift

//MARK: - 네트워크 매니저
class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchData<T: Decodable> (_ url: URL, _ header: HTTPHeaders) -> Single<T> {
        return Single<T>.create { single in
            AF.request(url, headers: header).responseDecodable(of: T.self) { response in
               switch response.result {
               case .success(let data) :
                   single(.success(data))
               case .failure(let error) :
                   single(.failure(error))
               }
           }
            return Disposables.create()
       }
    }
}
