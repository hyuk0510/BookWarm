//
//  RealmModel.swift
//  BookWarm
//
//  Created by 선상혁 on 2023/09/04.
//

import Foundation
import RealmSwift

class BookTable: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var author: String?
    @Persisted var imageURL: String?
    @Persisted var contents: String?
    @Persisted var selfMemo: String?
    @Persisted var titleAndMemo: String?
    
    convenience init(title: String, author: String?, imageURL: String?, contents: String?, memo: String?) {
        self.init()
        
        self.title = title
        self.author = author
        self.imageURL = imageURL
        self.contents = contents
        self.selfMemo = memo
        self.titleAndMemo = "책 제목: \(title), 메모: \(memo)"
    }
}
