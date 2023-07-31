//
//  DetailViewController.swift
//  BookWarm
//
//  Created by 선상혁 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    var viewTitle = ""
    
    @IBOutlet var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewTitle
        
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(closeButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        designDetailLabel()
    }
    
    @objc
    func closeButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func designDetailLabel() {
        detailLabel.text = "상세 화면"
        detailLabel.font = .boldSystemFont(ofSize: 50)
        detailLabel.textAlignment = .center
    }
}
