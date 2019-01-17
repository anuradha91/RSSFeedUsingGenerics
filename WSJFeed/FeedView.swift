//
//  FeedView.swift
//  WSJFeed
//
//  Created by Anuradha Sharma on 1/14/19.
//  Copyright © 2019 Anuradha Sharma. All rights reserved.
//

import UIKit

class FeedView: UIViewController {
    
    //MARK:- Properties
    private var rssItems: [RSSItem]?
    var currentIndex = Int()
    @IBOutlet weak var tableView: UITableView!
    fileprivate var datasource = GenericDataSource()

    
    //MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        tableView.estimatedRowHeight = 155.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func fetchData()
    {
        tableView.isHidden = true
        Spinner.start(from: self.view)
        let feedParser = FeedParser()
        feedParser.parseFeed(url: "http://www.wsj.com/xml/rss/3_7085.xml") { [weak self] (rssItems) in
            self?.rssItems = rssItems
            
            OperationQueue.main.addOperation { [weak self] in
                Spinner.stop()
                self?.setUpCell()
                self?.tableView.isHidden = false
                self?.tableView.reloadData()
            }
        }
    }
    
    fileprivate func setUpCell (){
        datasource.array = rssItems ?? []
        datasource.identifier = FeedCell.identifier
        tableView.dataSource = datasource
        tableView.delegate = datasource
        datasource.configure = {[weak self] cell, index  in
            guard let feedCell = cell as? FeedCell else { return }
            feedCell.item = self?.rssItems?[index]
        }
        datasource.didSelect = {[weak self] cell, index in
            guard let _ = cell as? FeedCell else { return }
            self?.currentIndex = index
            self?.performSegue(withIdentifier: "showDetail", sender: self)
        }
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let destVC = segue.destination as! FeedDetailView
        destVC.currentFeed = rssItems?[currentIndex]
    }
}
