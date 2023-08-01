//
//  DetailViewController.swift
//  BookWarm
//
//  Created by 선상혁 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    static let identifier = "DetailViewController"
    
    var viewTitle = ""
    var releaseDate = ""
    var runtime = ""
    var rate = ""
    var overView = ""
    
    @IBOutlet var detailImageView: UIImageView!
    
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var runtimeLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var overViewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewTitle
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(closeButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        designReleaseDateLabel()
        designRuntimeLabel()
        designRateLabel()
        designOverViewLabel()
        
        detailImageView.image = UIImage(named: viewTitle)
    }
    
    @objc
    func closeButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func designReleaseDateLabel() {
        releaseDateLabel.text = releaseDate
        releaseDateLabel.font = .boldSystemFont(ofSize: 15)
    }
    
    func designRuntimeLabel() {
        runtimeLabel.text = runtime
        runtimeLabel.font = .boldSystemFont(ofSize: 15)
    }
    
    func designRateLabel() {
        rateLabel.text = rate
        rateLabel.font = .boldSystemFont(ofSize: 15)
    }
    
    func designOverViewLabel() {
        overViewLabel.text = overView
        overViewLabel.font = .boldSystemFont(ofSize: 13)
        overViewLabel.numberOfLines = 0
    }
}
