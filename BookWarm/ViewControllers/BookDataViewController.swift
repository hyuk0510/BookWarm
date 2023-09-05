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
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tasks = realm.objects(BookTable.self)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    func showDeleteAlert(row: Int) {
        let data = tasks[row]

        let alert = UIAlertController(title: "삭제하시겠습니까?", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in

            self.deleteImageToDocument(fileName: "Sun_\(data._id).jpg")
            
            do {
                try self.realm.write {
                    self.realm.delete(data)
                }
            } catch {
                print("Delete Data Error")
            }
            self.tableView.reloadData()
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        
        present(alert, animated: true)
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

        cell.imageFoster.image = loadImageToDocument(fileName: "Sun_\(data._id).jpg")
        cell.title.text = data.title
        cell.author.text = data.author
        cell.contents.text = data.contents
        cell.memo.text = data.memo
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BookDataMemoController()
        vc.data = tasks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addMemo = UIContextualAction(style: .normal, title: "삭제") { action, view, completion in
            self.showDeleteAlert(row: indexPath.row)
        }
        
        return UISwipeActionsConfiguration(actions: [addMemo])
    }
    
}
