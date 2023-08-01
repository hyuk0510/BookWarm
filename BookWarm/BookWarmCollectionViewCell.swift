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
    
    func configureCell(data: Movie) {
        let likeButtonImage = data.isLike ? "hand.thumbsup.fill" : "hand.thumbsup"
        let row = bookWarmLikeButton.tag
        let movie = MovieInfo().movie
        
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = 15

        designBookWarmCellTitleLabel()
        designBookWarmCellRateLabel()
        
        bookWarmCellImageView.contentMode = .scaleAspectFit
        bookWarmCellTitleLabel.text = movie[row].title
        bookWarmCellRateLabel.text = "\(movie[row].rate)점"
        bookWarmCellImageView.image = UIImage(named: movie[row].title)
        bookWarmLikeButton.setImage(UIImage(systemName: likeButtonImage), for: .normal)
        bookWarmLikeButton.setTitle("", for: .normal)
        bookWarmLikeButton.tintColor = .white
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
