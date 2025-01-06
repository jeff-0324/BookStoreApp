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
import Kingfisher

class SearchViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let searchView = SearchView()
    private let viewModel = MainViewModel()
    
    private var recentBooks = [BookInfo]()
    private var searchBooks = [BookInfo]()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super .init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.tabBarItem = UITabBarItem(title: "Search",
                                       image: UIImage(systemName: "magnifyingglass"),
                                       tag: 0)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bind()
        setting()
    }
    
    //MARK: - setting
    private func setupUI() {
        view.addSubview(searchView)
        
        searchView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: - Binding
    private func bind() {
        //searchDataSubject Binding
        viewModel.searchDataSubject
            .observe(on: MainScheduler.instance)
            .subscribe (onNext: { [weak self] books in
                self?.searchBooks = books
                self?.searchView.collectionView.reloadData()
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
        
        //recentDataSubject Binding
        viewModel.recentDataSubject
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] books in
                self?.recentBooks = books
                self?.searchView.collectionView.reloadData()
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
    }
    
    //MARK: - enrolSetting
    private func setting() {
        searchView.searchBar.delegate = self
        
        searchView.collectionView.dataSource = self
        searchView.collectionView.delegate = self
        searchView.collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.id
        )
        searchView.collectionView.collectionViewLayout = creatLayout()
    }
    
    //MARK: - Section 구분
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
    
    //MARK: - CollectionView Layout
    func creatLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, enviroment in
            guard let sectionType = Section(rawValue: sectionIndex) else { return nil }
            
            switch sectionType {
            case .recentBooks:
                return self.createRecentBookLayout()
            case .searchBooks:
                return self.createSearchBookLayout()
            }
        }
    }
    
    //MARK: - RecentBook Layout
    private func createRecentBookLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(100),
            heightDimension: .absolute(140)
        )
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    //MARK: - SearchBook Layout
    private func createSearchBookLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(120)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(120)
        )
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 10, leading: 10, bottom: 20, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}

//MARK: - CollectionView 세팅(셀의 갯수)
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .recentBooks: return recentBooks.count
        case .searchBooks: return searchBooks.count
        case .none: return 0
        }
    }
    
    //MARK: - CollectionView 세팅(셀의 구성)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch Section(rawValue: indexPath.section) {
        case .recentBooks:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentBookCell.id, for: indexPath) as? RecentBookCell else {  return UICollectionViewCell()
            }
            cell.configure(with: recentBooks[indexPath.row])
            return cell
        case .searchBooks:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchListCell.id, for: indexPath) as? SearchListCell else {  return UICollectionViewCell()
            }
            cell.configure(with: searchBooks[indexPath.row])
            return cell
        case .none:
            break
        }
        return UICollectionViewCell()
    }
    
    //MARK: - Header Section 구분
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        guard let section = Section(rawValue: indexPath.section) else {
            return UICollectionReusableView()
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SectionHeaderView.id,
            for: indexPath
        ) as! SectionHeaderView
        
        headerView.configure(with: section.title)
        return headerView
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
}

//MARK: - CollectionView 세팅(셀의 선택시)
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = DetailViewController()
        let section = Section(rawValue: indexPath.section)
        let selectedBook: BookInfo
        
        
        switch section {
        case .recentBooks:
            selectedBook = recentBooks[indexPath.row]
        case .searchBooks:
            selectedBook = searchBooks[indexPath.row]
        default :
            return
        }
        
        detailVC.configure(with: selectedBook)
        
        CoreDataManager.shared.addToRecentBooks(book: selectedBook)
        
        detailVC.modalPresentationStyle = .pageSheet
        present(detailVC, animated: true)
    }
}

//MARK: - SearchBar 입력
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.fetchSearchData(query: searchBar.text!)
    }
}


