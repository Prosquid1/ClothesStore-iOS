//
//  UI+Extensions.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/12/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

extension UIView {
    func loadViewFromNib() -> UIView {
        let selfClass = Swift.type(of: self)
        let bundle = Bundle(for: selfClass)
        let nib = UINib(nibName: String(describing: selfClass), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView

        return view
    }
    
    func rotate(degrees: CGFloat) {
        rotate(radians: CGFloat.pi * degrees / 180.0)
    }

    func rotate(radians: CGFloat) {
        self.transform = CGAffineTransform(rotationAngle: radians)
    }

    internal func xibSetup() {
        let contentView = loadViewFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleTopMargin]
        contentView.translatesAutoresizingMaskIntoConstraints = true
        addSubview(contentView)
    }

}

extension CGRect {
    var minEdge: CGFloat {
        return min(width, height)
    }
}

extension UIRefreshControl {
    func beginRefreshingManually() {
        if let scrollView = superview as? UIScrollView {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y - frame.height), animated: true)
        }
        beginRefreshing()
    }
}
