//
//  BookSearchViewController.swift
//  BookWarm
//
//  Created by 선상혁 on 2023/08/09.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import RealmSwift

struct Book {
    let title: String
    let author: String
    let contents: String
    let thumbnail: String
}

class BookSearchViewController: UIViewController {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var bookSearchTableView: UITableView!
    
    var bookList: [Book] = []
    var page = 0
    var isEnd = false
    
    static let identifier = "BookSearchViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: BookSearchTableViewCell.identifier, bundle: nil)
        
        bookSearchTableView.register(nib, forCellReuseIdentifier: BookSearchTableViewCell.identifier)

        searchBar.delegate = self
        bookSearchTableView.delegate = self
        bookSearchTableView.dataSource = self
        bookSearchTableView.prefetchDataSource = self
        bookSearchTableView.rowHeight = 200
        
    }
    
    func callRequest(query: String, page: Int) {
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://dapi.kakao.com/v3/search/book?target=title&query=\(text)&page=\(page)&size=5"
        let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.kakaoSearch)"]
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                self.isEnd = json["meta"]["is_end"].boolValue
                var authors = ""
                
                for item in json["documents"].arrayValue {
                    let title = item["title"].stringValue
                    let authors = item["authors"].arrayValue.map{$0.stringValue}.joined(separator: ", ")
                    let contents = item["contents"].stringValue
                    let imageURL = item["thumbnail"].stringValue
                    
                    let data = Book(title: title, author: authors, contents: contents, thumbnail: imageURL)
                    
                    self.bookList.append(data)
                }
                self.bookSearchTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension BookSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        page = 1
        bookList.removeAll()
        
        guard let query = searchBar.text else {
            return
        }
        callRequest(query: query, page: page)
    }
}

extension BookSearchViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookSearchTableViewCell.identifier) as? BookSearchTableViewCell else {
            return UITableViewCell()
        }
        
        let row = indexPath.row
        if let url = URL(string: bookList[indexPath.row].thumbnail) {
            cell.bookImageView.kf.setImage(with: url)
        }
        
        cell.titleLabel.text = bookList[row].title
        cell.authorLabel.text = bookList[row].author
        cell.contentsLabel.text = bookList[row].contents
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let realm = try! Realm()
        
        let task = BookTable(title: bookList[indexPath.row].title, author: bookList[indexPath.row].author, imageURL: bookList[indexPath.row].thumbnail, contents: bookList[indexPath.row].contents)
        
        try! realm.write {
            realm.add(task)
            print("Realm Add Succeed")
        }
        
        let vc = BookDataViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if bookList.count - 1 == indexPath.row && page < 10 && !isEnd {
                page += 1
                callRequest(query: searchBar.text!, page: page)
            }
        }
    }

    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
    }
}
