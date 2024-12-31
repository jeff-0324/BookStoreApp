//
//  SearchView.swift
//  bookstoreApp
//
//  Created by jae hoon lee on 12/29/24.
//

import UIKit
import SnapKit

class SearchView: UIView {
    
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
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
            return section
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        collectionView.register(SearchListCell.self, forCellWithReuseIdentifier: SearchListCell.id)
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
