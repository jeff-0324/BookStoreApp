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

struct RecentBook {
    let authors: [String]
    let contents: String
    let thumbnail: String
    let title: String
}

class SearchViewController: UIViewController {
    
    // 더미 데이터
    let recentBook: [RecentBook] = [RecentBook(
        authors : [ "세이노" ],
        contents : "2000년부터 발표된 그의 주옥같은 글들. 독자들이 자발적으로 만든 제본서는 물론, 전자책과 앱까지 나왔던 《세이노의 가르침》이 드디어 전국 서점에서 독자들을 마주한다. 여러 판본을 모으고 저자의 확인을 거쳐 최근 생각을 추가로 수록하였다. 정식 출간본에만 추가로 수록된 글들은 목차와 본문에 별도 표시하였다.  더 많은 사람이 이 책을 보고 힘을 얻길 바라기에 인세도 안 받는 저자의 마음을 담아, 700쪽이 넘는 분량에도 7천 원 안팎에 책을 구매할",
        thumbnail : "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F6266671%3Ftimestamp%3D20241228151802",
        title : "세이노의 가르침(올블랙 유광 에디션)"
    ),RecentBook(
        authors : [ "한강" ],
        contents : "2014년 만해문학상, 2017년 이탈리아 말라파르테 문학상을 수상하고 전세계 20여개국에 번역 출간되며 세계를 사로잡은 우리 시대의 소설 『소년이 온다』. 이 작품은 『채식주의자』로 인터내셔널 부커상을 수상한 한강 작가에게 “눈을 뗄 수 없는, 보편적이며 깊은 울림”(뉴욕타임즈), “역사와 인간의 본질을 다룬 충격적이고 도발적인 소설”(가디언), “한강을 뛰어넘은 한강의 소설”(문학평론가 신형철)이라는 찬사를 선사한 작품으로, 그간 많은 독자들",
        thumbnail : "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F6266671%3Ftimestamp%3D20241228151802",
        title : "소년이 온다"
    ),RecentBook(
        authors : [ "한강" ],
        contents : "2014년 만해문학상, 2017년 이탈리아 말라파르테 문학상을 수상하고 전세계 20여개국에 번역 출간되며 세계를 사로잡은 우리 시대의 소설 『소년이 온다』. 이 작품은 『채식주의자』로 인터내셔널 부커상을 수상한 한강 작가에게 “눈을 뗄 수 없는, 보편적이며 깊은 울림”(뉴욕타임즈), “역사와 인간의 본질을 다룬 충격적이고 도발적인 소설”(가디언), “한강을 뛰어넘은 한강의 소설”(문학평론가 신형철)이라는 찬사를 선사한 작품으로, 그간 많은 독자들",
        thumbnail : "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F6266671%3Ftimestamp%3D20241228151802",
        title : "소년이 온다"
    )
    ]
    
    let searchBook: [RecentBook] = [RecentBook(
        authors : [ "세이노" ],
        contents : "2000년부터 발표된 그의 주옥같은 글들. 독자들이 자발적으로 만든 제본서는 물론, 전자책과 앱까지 나왔던 《세이노의 가르침》이 드디어 전국 서점에서 독자들을 마주한다. 여러 판본을 모으고 저자의 확인을 거쳐 최근 생각을 추가로 수록하였다. 정식 출간본에만 추가로 수록된 글들은 목차와 본문에 별도 표시하였다.  더 많은 사람이 이 책을 보고 힘을 얻길 바라기에 인세도 안 받는 저자의 마음을 담아, 700쪽이 넘는 분량에도 7천 원 안팎에 책을 구매할",
        thumbnail : "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F6266671%3Ftimestamp%3D20241228151802",
        title : "세이노의 가르침(올블랙 유광 에디션)"
    ),RecentBook(
        authors : [ "한강" ],
        contents : "2014년 만해문학상, 2017년 이탈리아 말라파르테 문학상을 수상하고 전세계 20여개국에 번역 출간되며 세계를 사로잡은 우리 시대의 소설 『소년이 온다』. 이 작품은 『채식주의자』로 인터내셔널 부커상을 수상한 한강 작가에게 “눈을 뗄 수 없는, 보편적이며 깊은 울림”(뉴욕타임즈), “역사와 인간의 본질을 다룬 충격적이고 도발적인 소설”(가디언), “한강을 뛰어넘은 한강의 소설”(문학평론가 신형철)이라는 찬사를 선사한 작품으로, 그간 많은 독자들",
        thumbnail : "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F6266671%3Ftimestamp%3D20241228151802",
        title : "소년이 온다"
    ),RecentBook(
        authors : [ "한강" ],
        contents : "2014년 만해문학상, 2017년 이탈리아 말라파르테 문학상을 수상하고 전세계 20여개국에 번역 출간되며 세계를 사로잡은 우리 시대의 소설 『소년이 온다』. 이 작품은 『채식주의자』로 인터내셔널 부커상을 수상한 한강 작가에게 “눈을 뗄 수 없는, 보편적이며 깊은 울림”(뉴욕타임즈), “역사와 인간의 본질을 다룬 충격적이고 도발적인 소설”(가디언), “한강을 뛰어넘은 한강의 소설”(문학평론가 신형철)이라는 찬사를 선사한 작품으로, 그간 많은 독자들",
        thumbnail : "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F6266671%3Ftimestamp%3D20241228151802",
        title : "소년이 온다"
    )
    ]
    
    private let searchView = SearchView()
    let disposeBag = DisposeBag()
    
    var recentBooks = [BookInfo]()
    var searchBooks = [BookInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchSearchData(query: "한강")
        
        searchView.collectionView.dataSource = self
        searchView.collectionView.delegate = self
    }
    
    func setupUI() {
        view.addSubview(searchView)
        
        searchView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
    case recentBook
    case searchBook
    
    var title: String {
        switch self {
        case .recentBook: return "최근 본 책"
        case .searchBook: return "검색 결과"
        }
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .recentBook: return recentBook.count
        case .searchBook: return searchBook.count
        case .none: return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchListCell.id, for: indexPath) as? SearchListCell else {  return UICollectionViewCell()
        }
        
        switch Section(rawValue: indexPath.section) {
        case .recentBook:
            cell.configure(with: recentBook[indexPath.row])
        case .searchBook:
            cell.configure(with: searchBook[indexPath.row])
        case .none:
            break
        }
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
}

extension SearchViewController {
    
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
}
