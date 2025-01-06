//
//  SearchListCell.swift
//  bookstoreApp
//
//  Created by jae hoon lee on 12/29/24.
//

import UIKit
import SnapKit

class SearchListCell: UICollectionViewCell {
    static let id: String = "SearchListCell"
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    var bookNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .left
        return label
    }()
    
    var bookAuthorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSearchViewUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupSearchViewUI() {
        
        [
            bookNameLabel,
            bookAuthorLabel
        ].forEach { verticalStackView.addArrangedSubview($0) }
        
        [
            imageView,
            verticalStackView
        ].forEach { contentView.addSubview($0) }
        
        imageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(80)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(30)
            make.leading.equalTo(imageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(10)
        }
        
        contentView.layer.cornerRadius = 5
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
     func configure(with book: BookInfo ) {
        bookNameLabel.text = book.title
        bookAuthorLabel.text = book.authors.joined(separator: ", ")
        if let url = URL(string: book.thumbnail) {
                imageView.kf.setImage(with: url) // Kingfisher를 사용해 이미지 설정
            } else {
                imageView.image = UIImage(named: "placeholder") // 기본 이미지
            }
    }
}
