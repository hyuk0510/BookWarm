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
    
    let imageFoster = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    let contents = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.textColor = .black
        view.numberOfLines = 0
        return view
    }()
    
    let memo = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 12)
        view.textColor = .red
        view.numberOfLines = 0
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
        [title, author, imageFoster, contents, memo].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setConstraints() {
        imageFoster.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(contentView).offset(10)
            make.width.equalTo(imageFoster.snp.height).multipliedBy(0.6)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(imageFoster.snp.trailing).offset(10)
            make.height.equalTo(20)
        }
        author.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(8)
            make.leading.equalTo(title.snp.leading)
            make.height.equalTo(20)
        }
        
        contents.snp.makeConstraints { make in
            make.top.equalTo(author.snp.bottom).offset(8)
            make.leading.equalTo(title.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
            make.height.equalTo(20)
        }
        
        memo.snp.makeConstraints { make in
            make.top.equalTo(contents.snp.bottom).offset(8)
            make.leading.equalTo(title.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
            make.height.equalTo(20)
        }
    }
    

}
