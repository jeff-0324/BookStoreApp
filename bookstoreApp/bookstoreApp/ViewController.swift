//
//  ViewController.swift
//  bookstoreApp
//
//  Created by jae hoon lee on 12/29/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private let searchView = SearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        setupUI()
    }

    func setupUI() {
        view.addSubview(searchView)
        
        searchView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

