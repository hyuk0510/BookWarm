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
    
    lazy var memoTextField = {
        let view = UITextField()
        view.placeholder = "메모를 입력해주세요."
        view.textColor = .black
        view.font = .systemFont(ofSize: 12)
        view.backgroundColor = .yellow
        view.textAlignment = .natural
        view.delegate = self
        return view
    }()
    
    var data: BookTable?
    let repository = BookTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(memoTextField)
        memoTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(200)
        }
        
        guard let data = data else { return }
        memoTextField.text = data.selfMemo
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(okButtonPressed))
    }
    
    @objc func okButtonPressed() {
        guard let data = data else { return }
        
        repository.updateMemo(id: data._id, memo: memoTextField.text ?? "")
        
        navigationController?.popViewController(animated: true)
    }
}

extension BookDataMemoController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if memoTextField.text != nil {
            memoTextField.text = nil
        }
    }
}
