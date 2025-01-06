//
//  DetailViewController.swift
//  bookstoreApp
//
//  Created by jae hoon lee on 1/6/25.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    private let detailView = DetailView()
    private var bookInfo: BookInfo?

    func configure(with book: BookInfo) {
        self.bookInfo = book
    }
    
    func configure1(with book: RecentBook) {
        self.title = book.title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUI()
        
        // bookInfo를 기반으로 UI 구성
        if let bookInfo = bookInfo {
            print("print")
        }
    }
    
    func setupUI() {
        view.addSubview(detailView)
        
        detailView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    func updateUI() {
        guard let bookInfos = bookInfo else { return }
        detailView.update(with: bookInfos)
    }
}
