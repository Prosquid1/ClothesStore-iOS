//
//  BaseViewController.swift
//
//  Created by Oyeleke Okiki on 7/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import SwiftEntryKit

class BaseViewController: UITableViewController {

    let blankFooterView = UIView()
    
    var _refreshControl: UIRefreshControl!
    var refreshStarted: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        setup()
    }
    
    private func setup() {
        tableView.separatorInset.left = 0
        tableView.separatorColor =  ColorPalette.tableSeparator
        
        _refreshControl = UIRefreshControl()
        _refreshControl.tintColor = ColorPalette.primary
        if #available(iOS 10.0, *) {
            refreshControl = _refreshControl
        } else {
            tableView.addSubview(_refreshControl)
        }
        // uikit issue-fix: called to change tint color
        _refreshControl.beginRefreshingManually()
        _refreshControl.endRefreshing()
        
        _refreshControl.addTarget(self, action: #selector(refreshTriggered(_:)), for: .valueChanged)
    }
    
    @objc private func refreshTriggered(_ sender: Any) {
        // Fetch Data
        refreshStarted?()
    }

    func refreshViewForNewDataState() {
        _refreshControl.endRefreshing()
        tableView.reloadData()
        UIView.animate(views: tableView.visibleCells, animations: AnimationUtils.tableViewAnimations)
    }
}

extension BaseViewController {
    //To prevent lines from showing in empty tableview spaces
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return blankFooterView
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}
