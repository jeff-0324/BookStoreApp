//
//  RecentBookCell.swift
//  bookstoreApp
//
//  Created by jae hoon lee on 1/5/25.
//

import UIKit

class RecentBookCell: UICollectionViewCell {
    static let id: String = "RecentBookCell"
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    var bookNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        return label
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.backgroundColor = .yellow
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupRecentBookUI()
        backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupRecentBookUI() {
        [
            imageView,
            bookNameLabel
        ].forEach { verticalStackView.addArrangedSubview($0) }
        
        [
            verticalStackView
        ].forEach { contentView.addSubview($0) }
        
        verticalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(100)
        }
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.width.equalTo(80)
           
        }
        
        bookNameLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
            
        }
    }
}
