//
//  MyCartViewController.swift
//  bookstoreApp
//
//  Created by jae hoon lee on 1/6/25.
//

import UIKit

class MyCartViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super .init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.tabBarItem = UITabBarItem(title: "MyCart",
                                       image: UIImage(systemName: "books.vertical"),
                                       tag: 0)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
