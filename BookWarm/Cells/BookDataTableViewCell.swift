//
//  BookDataTableViewCell.swift
//  BookWarm
//
//  Created by 선상혁 on 2023/09/05.
//

import UIKit
import SnapKit

class BookDataTableViewCell: UITableViewCell {
    
    let title = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.textColor = .black
        return view
    }()
    
    let author = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.textColor = .black
        return view
    }()
    
    let imageURL = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.textColor = .black
        return view
    }()
    
    let contents = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.textColor = .black
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        [title, author, imageURL, contents].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setConstraints() {
        title.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.height.equalTo(20)
        }
        author.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(8)
            make.height.equalTo(20)
        }
        imageURL.snp.makeConstraints { make in
            make.top.equalTo(author.snp.bottom).offset(8)
            make.height.equalTo(20)
        }
        contents.snp.makeConstraints { make in
            make.top.equalTo(imageURL.snp.bottom).offset(8)
            make.height.equalTo(20)
        }
    }
    

}
