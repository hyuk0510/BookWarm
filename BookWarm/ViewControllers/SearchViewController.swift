//
//  SearchViewController.swift
//  BookWarm
//
//  Created by 선상혁 on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var recentSearchLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "검색 화면"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        designRecentSearchLabel()
    }
    
    @objc
    func closeButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func designRecentSearchLabel() {
        recentSearchLabel.text = "검색해주세요"
        recentSearchLabel.font = .boldSystemFont(ofSize: 50)
        recentSearchLabel.textAlignment = .center
    }
}
