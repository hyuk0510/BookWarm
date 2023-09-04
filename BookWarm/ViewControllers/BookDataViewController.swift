//
//  BookDataViewController.swift
//  BookWarm
//
//  Created by 선상혁 on 2023/09/05.
//

import UIKit
import SnapKit
import RealmSwift

class BookDataViewController: UIViewController {

    lazy var tableView = {
        let view = UITableView()
        view.rowHeight = 200
        view.delegate = self
        view.dataSource = self
        view.register(BookDataTableViewCell.self, forCellReuseIdentifier: BookDataTableViewCell.reuseIdentifier)
        return view
    }()
    
    var tasks: Results<BookTable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        let realm = try! Realm()
        tasks = realm.objects(BookTable.self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
}

extension BookDataViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookDataTableViewCell.reuseIdentifier) as? BookDataTableViewCell else {
            return UITableViewCell()
        }
        
        let data = tasks[indexPath.row]        
        
        cell.title.text = data.title
        cell.author.text = data.author
        cell.imageURL.text = data.imageURL
        cell.contents.text = data.contents
        
        return cell
    }
    
    
}
