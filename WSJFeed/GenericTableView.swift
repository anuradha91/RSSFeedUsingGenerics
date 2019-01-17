//
//  GenericTableView.swift
//  WSJFeed
//
//  Created by Anuradha Sharma on 1/17/19.
//  Copyright © 2019 Anuradha Sharma. All rights reserved.
//

import Foundation

import UIKit

class GenericDataSource<T: UITableViewCell>: NSObject , UITableViewDataSource, UITableViewDelegate {
    var didSelect: (T, Int) -> () = { _, _ in}
    var configure : ((T, Int) -> ())?
    var identifier = String()
    var array: [Any] = []
    
    func registerCells(forTableView tableView: UITableView) {
        tableView.register(UINib(nibName: "", bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func loadCell(atIndexPath indexPath: IndexPath, forTableView tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        configure?(cell as! T, indexPath.row)
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.loadCell(atIndexPath: indexPath, forTableView: tableView)
    }
    
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)      {
        let cell = tableView.cellForRow(at: indexPath)
        didSelect(cell as! T, indexPath.row)
    }
}
