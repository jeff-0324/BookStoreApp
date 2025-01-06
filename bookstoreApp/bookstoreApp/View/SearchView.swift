//
//  SearchView.swift
//  bookstoreApp
//
//  Created by jae hoon lee on 12/29/24.
//

import UIKit
import SnapKit

class SearchView: UIView {
    
     var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "검색할 단어를 입력해주세요."
        searchBar.showsCancelButton = true
        return searchBar
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        collectionView.register(SearchListCell.self, forCellWithReuseIdentifier: SearchListCell.id)
        collectionView.register(RecentBookCell.self, forCellWithReuseIdentifier: RecentBookCell.id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .white
        [
            searchBar,
            collectionView
        ].forEach { addSubview($0) }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(80)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }
    }
}
