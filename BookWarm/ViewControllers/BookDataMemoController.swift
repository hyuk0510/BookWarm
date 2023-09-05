//
//  BookDataMemoController.swift
//  BookWarm
//
//  Created by 선상혁 on 2023/09/05.
//

import UIKit
import SnapKit
import RealmSwift

class BookDataMemoController: UIViewController {
    
    let memoTextField = {
        let view = UITextField()
        view.placeholder = "메모를 입력해주세요."
        view.textColor = .black
        view.font = .systemFont(ofSize: 12)
        view.backgroundColor = .yellow
        return view
    }()
    
    let realm = try! Realm()
    var data: BookTable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(memoTextField)
        memoTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(200)
        }
        guard let data = data else { return }

        memoTextField.text = data.memo
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(okButtonPressed))
    }
    
    @objc func okButtonPressed() {
        guard let data = data else { return }
        let item = BookTable(value: ["_id": data._id, "title": data.title, "author": data.author, "contents": data.contents, "memo": memoTextField.text!])
        
        do {
            try realm.write {
                realm.add(item, update: .modified)
            }
        } catch {
            print("Memo edit ERROR")
        }
        
        navigationController?.popViewController(animated: true)
    }
}
