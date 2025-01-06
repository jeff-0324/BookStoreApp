//
//  DetailView.swift
//  bookstoreApp
//
//  Created by jae hoon lee on 1/6/25.
//

import UIKit
import SnapKit

class DetailView: UIView {
    
    var bookNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.textAlignment = .center
        return label
    }()
    
    var bookAuthorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var bookPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    var bookContentsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    let addCartButton: UIButton = {
        let button = UIButton()
        button.setTitle("담기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        return stackView
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        scrollView.addSubview(bookContentsLabel)
        
        [
            closeButton,
            addCartButton
        ].forEach { horizontalStackView.addArrangedSubview($0) }
        
        [
            bookNameLabel,
            bookAuthorLabel,
            imageView,
            bookPriceLabel,
            scrollView,
            horizontalStackView
        ].forEach { addSubview($0) }

        bookNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.height.equalTo(40)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        bookAuthorLabel.snp.makeConstraints { make in
            make.top.equalTo(bookNameLabel.snp.bottom).offset(15)
            make.height.equalTo(20)
            make.horizontalEdges.equalToSuperview().inset(10)

        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(bookAuthorLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(350)
            make.width.equalTo(250)
        }
        
        bookPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.height.equalTo(30)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(bookPriceLabel.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(horizontalStackView.snp.top)
            make.height.equalTo(200)
        }
        
        bookContentsLabel.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.equalTo(200)
        }
        
        horizontalStackView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(150)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        self.bringSubviewToFront(horizontalStackView)
        
        closeButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        addCartButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
    
    func update(with book: BookInfo ) {
        bookNameLabel.text = book.title
        bookAuthorLabel.text = book.authors.joined(separator: ", ")
        bookPriceLabel.text = "\(PriceFormatModel.wonFormat(Int(book.price)))"
        bookContentsLabel.text = book.contents
       if let url = URL(string: book.thumbnail) {
               imageView.kf.setImage(with: url) // Kingfisher를 사용해 이미지 설정
           } else {
               imageView.image = UIImage(named: "placeholder") // 기본 이미지
           }
   }
}
