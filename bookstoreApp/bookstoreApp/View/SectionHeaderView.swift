//
//  SectionHeaderView.swift
//  bookstoreApp
//
//  Created by jae hoon lee on 12/30/24.
//

import UIKit
import SnapKit

class SectionHeaderView: UICollectionReusableView {
    static let id = "SectionHeaderView"
    
    let titleLable: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(titleLable)
        
        titleLable.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.verticalEdges.equalToSuperview().inset(5)
        }
    }
    
    func configure(with title: String) {
        titleLable.text = title
    }
    
    
}
