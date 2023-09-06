//
//  BookTableRepository.swift
//  BookWarm
//
//  Created by 선상혁 on 2023/09/06.
//

import Foundation
import RealmSwift

class BookTableRepository {
    
    private let realm = try! Realm()
    
    func fetch() -> Results<BookTable> {
        print(realm.objects(BookTable.self))
        return realm.objects(BookTable.self)
    }
    
    func addData(_ data: BookTable) {
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print(error)
        }
    }
    
    func updateMemo(id: ObjectId, memo: String) {
        do {
            try realm.write {
                realm.create(BookTable.self, value: ["_id": id, "memo": memo], update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteData(_ data: BookTable) {
        do {
            try self.realm.write {
                self.realm.delete(data)
            }
        } catch {
            print(error)
        }
    }
    
}
