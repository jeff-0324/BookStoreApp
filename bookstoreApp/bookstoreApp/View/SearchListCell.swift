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
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let bookNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textAlignment = .left
        return label
    }()
    
    private let bookAuthorLabel: UILabel = {
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
        stackView.spacing = 10
        return stackView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupUI() {
        
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
            make.width.equalTo(70)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.leading.equalTo(imageView.snp.trailing).inset(20)
        }
    }
    
    func configure(with book: RecentBook ) {
        bookNameLabel.text = book.title
        bookAuthorLabel.text = book.authors.joined(separator: ", ")
        //imageView.image = image
    }
    
}
