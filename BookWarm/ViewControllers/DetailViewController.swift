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
    var placeholderText = "메모를 입력해주세요"
    
    @IBOutlet var detailImageView: UIImageView!
    
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var runtimeLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var overViewLabel: UILabel!
    
    @IBOutlet var memoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewTitle
        
        memoTextView.delegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(closeButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        designReleaseDateLabel()
        designRuntimeLabel()
        designRateLabel()
        designOverViewLabel()
        designMemoTextView()
        
        detailImageView.image = UIImage(named: viewTitle)
    }
    
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    @objc
    func closeButtonPressed() {
        
        if (self.presentingViewController) != nil {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
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
    
    func getData(data: Movie) {
        viewTitle = data.title
        releaseDate = "개봉일: \(data.releaseDate)"
        runtime = "상영 시간: \(data.runtime)분"
        overView = data.overview
        rate = "평점: \(data.rate)점"
    }
    
    func designMemoTextView() {
        memoTextView.text = placeholderText
        memoTextView.backgroundColor = .systemGray
        memoTextView.font = .boldSystemFont(ofSize: 13)
        memoTextView.textColor = .white
    }
}

extension DetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = nil
            textView.textColor = .black
            textView.font = .boldSystemFont(ofSize: 15)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            designMemoTextView()
        }
    }
}
