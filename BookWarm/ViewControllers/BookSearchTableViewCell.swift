//
//  BookSearchTableViewCell.swift
//  BookWarm
//
//  Created by 선상혁 on 2023/08/09.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class BookSearchTableViewCell: UITableViewCell {

    @IBOutlet var bookImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var contentsLabel: UILabel!
    
    static let identifier = "BookSearchTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bookImageView.contentMode = .scaleToFill
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.textAlignment = .center
        authorLabel.font = .systemFont(ofSize: 13)
        authorLabel.textAlignment = .center
        contentsLabel.font = .systemFont(ofSize: 12)
        contentsLabel.numberOfLines = 0
    }
}
