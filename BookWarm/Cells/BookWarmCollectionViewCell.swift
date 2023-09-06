//
//  BookWarmCollectionViewCell.swift
//  BookWarm
//
//  Created by 선상혁 on 2023/07/31.
//

import UIKit

class BookWarmCollectionViewCell: UICollectionViewCell {

    @IBOutlet var bookWarmCellTitleLabel: UILabel!
    @IBOutlet var bookWarmCellRateLabel: UILabel!
    
    @IBOutlet var bookWarmLikeButton: UIButton!
    
    @IBOutlet var bookWarmCellImageView: UIImageView!
        
    override func awakeFromNib() {
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = 15

        designBookWarmCellTitleLabel()
        designBookWarmCellRateLabel()
        
        bookWarmCellImageView.contentMode = .scaleAspectFit
        bookWarmLikeButton.setTitle("", for: .normal)
        bookWarmLikeButton.tintColor = .white
    }
    
    func configureCell(data: Movie) {
        let likeButtonImage = data.isLike ? "hand.thumbsup.fill" : "hand.thumbsup"
        let row = bookWarmLikeButton.tag
        
        bookWarmCellTitleLabel.text = data.title
        bookWarmCellRateLabel.text = "\(data.rate)점"
        bookWarmCellImageView.image = UIImage(named: data.title)
        bookWarmLikeButton.setImage(UIImage(systemName: likeButtonImage), for: .normal)
    }
    
    func designBookWarmCellTitleLabel() {
        bookWarmCellTitleLabel.font = .boldSystemFont(ofSize: 15)
        bookWarmCellTitleLabel.textColor = .white
    }
    
    func designBookWarmCellRateLabel() {
        bookWarmCellRateLabel.font = .boldSystemFont(ofSize: 10)
        bookWarmCellRateLabel.textColor = .white
        bookWarmCellRateLabel.textAlignment = .center
    }
}
