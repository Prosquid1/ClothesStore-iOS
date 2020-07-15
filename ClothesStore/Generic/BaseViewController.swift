//
//  BaseViewController.swift
//
//  Created by Oyeleke Okiki on 7/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SwiftEntryKit

class BaseViewController: UITableViewController, NVActivityIndicatorViewable {

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
        tableView.separatorColor = .clear

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
        // Fetch Services Data
        refreshStarted?()
    }

    func startNVAnimation() {
        if isAnimating { return }
        startAnimating(CGSize(width: 50.0, height: 50.0),
                       type: NVActivityIndicatorType.ballScaleRipple,
                       color: ColorPalette.primaryDark, fadeInAnimation: nil)
    }

    func stopNVAnimation() {
        if !isAnimating { return }
        stopAnimating()
    }


    func refreshViewForNewDataState() {
        _refreshControl.endRefreshing()
        tableView.reloadData()
    }

}
