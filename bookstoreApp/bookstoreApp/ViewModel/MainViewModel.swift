//
//  MainViewModel.swift
//  bookstoreApp
//
//  Created by jae hoon lee on 1/6/25.
//

import UIKit
import Alamofire
import RxSwift

class MainViewModel {
    
    private let disposeBag = DisposeBag()
    
    let searchDataSubject = BehaviorSubject(value: [BookInfo]())
    let recentDataSubject = BehaviorSubject(value: [BookInfo]())
    
    //MARK: - api요청
    func fetchSearchData(query: String) {
        guard let url = URL(string: "https://dapi.kakao.com/v3/search/book?query=\(query)") else {
            searchDataSubject.onError(NetworkError.invalidUrl)
            return
        }
        
        let header: HTTPHeaders = ["Authorization": "KakaoAK 2650b14821af8f320b2b30c04f351189"]
        
        NetworkManager.shared.fetchData(url, header)
            .subscribe(onSuccess: { [weak self] (bookInfoResponse: BookInformation) in
                self?.searchDataSubject.onNext(bookInfoResponse.documents.map{ BookInfo(from: $0) })},
                       onFailure: { [weak self] error in
                self?.searchDataSubject.onError(error)
            }).disposed(by: disposeBag)
    }
    
    
}




