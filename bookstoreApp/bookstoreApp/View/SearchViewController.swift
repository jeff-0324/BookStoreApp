//
//  SearchViewController.swift
//  bookstoreApp
//
//  Created by jae hoon lee on 12/30/24.
//

import UIKit
import SnapKit
import RxSwift
import Alamofire

class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
    let disposeBag = DisposeBag()
    
    var recentBooks = [BookInfo]()
    var searchBooks = [BookInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(searchView)
        
        searchView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: - api요청
    func fetchSearchData(query: String) {
        guard let url = URL(string: "https://dapi.kakao.com/v3/search/book?query=\(query)") else {
            print("url이 잘못되었습니다.")
            return
        }
        
        let header: HTTPHeaders = ["Authorization": "KakaoAK 2650b14821af8f320b2b30c04f351189"]
        
        NetworkManager.shared.fetchData(url, header)
            .subscribe(onSuccess: { (bookinfoResponse: BookInfo) in
                print(bookinfoResponse)
            }, onFailure: {  error in
                print(error)
            }).disposed(by: disposeBag)
    }
    
    func creatLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
                                               heightDimension: .fractionalHeight(0.6)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 10, leading: 10, bottom: 20, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

enum Section: Int, CaseIterable {
    case recentBooks
    case searchBooks
    
    var title: String {
        switch self {
        case .recentBooks: return "최근 본 책"
        case .searchBooks: return "검색 결과"
        }
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .recentBooks: return recentBooks.count
        case .searchBooks: return searchBooks.count
        case .none: return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchListCell.id, for: indexPath) as? SearchListCell else {  return UICollectionViewCell()
        }
        
//        switch Section(rawValue: indexPath.section) {
//        case .recentBooks:
//            cell.configure(with: [indexPath.row], title: [indexPath.row], authors: [indexPath.row])
//        case .searchBooks:
//            cell.
//        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: SectionHeaderView.id,
                                                                               for: indexPath) as? SectionHeaderView else { return UICollectionReusableView() }
        
        let sectionType = Section.allCases[indexPath.section]
        headerView.configure(with: sectionType.title)
        
        return headerView
        
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
}

extension SearchViewController {
    
    
}
