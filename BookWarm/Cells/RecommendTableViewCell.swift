//
//  RecommendTableViewCell.swift
//  BookWarm
//
//  Created by 선상혁 on 2023/08/02.
//

import UIKit

class RecommendTableViewCell: UITableViewCell {

    @IBOutlet var recommendImageView: UIImageView!
    
    @IBOutlet var recommendTitleLabel: UILabel!
    @IBOutlet var recommendDetailLabel: UILabel!
        
    let movie = MovieInfo().movie
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        recommendTitleLabel.font = .boldSystemFont(ofSize: 17)
        recommendDetailLabel.font = .boldSystemFont(ofSize: 13)
    }
    
    func configureRecommendTableViewCell() {
        
        let row = recommendTitleLabel.tag
        
        recommendImageView.image = UIImage(named: movie[row].title)
        recommendImageView.contentMode = .scaleAspectFit
        recommendTitleLabel.text = movie[row].title
        recommendDetailLabel.text = "\(movie[row].releaseDate) | \(movie[row].runtime)분 | \(movie[row].rate)점"
    }
}
