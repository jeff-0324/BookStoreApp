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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUI()
    }
    
    func setupUI() {
        view.addSubview(detailView)
        
        detailView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(with book: BookInfo) {
        self.bookInfo = book
    }
    
    func updateUI() {
        guard let bookInfos = bookInfo else { return }
        detailView.update(with: bookInfos)
    }
}
