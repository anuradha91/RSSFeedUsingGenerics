//
//  ReuseableCell.swift
//  WSJFeed
//
//  Created by Anuradha Sharma on 1/17/19.
//  Copyright © 2019 Anuradha Sharma. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableCell {
    static var identifier: String { get }
    static var nib: UINib { get }
}

extension ReusableCell where Self: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
