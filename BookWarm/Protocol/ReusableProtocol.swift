//
//  ReusableProtocol.swift
//  BookWarm
//
//  Created by 선상혁 on 2023/09/05.
//

import UIKit

protocol ReusableViewProtocol: AnyObject {
    static var reuseIdentifier: String { get }
    
}

extension UIViewController: ReusableViewProtocol {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableViewProtocol {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}
extension UITableViewCell: ReusableViewProtocol {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

