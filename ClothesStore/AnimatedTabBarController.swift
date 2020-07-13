//
//  AnimatedTabBarController.swift

//  Added by Oyeleke Okiki on 12/07/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class AnimatedTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1: UIViewController = CartController()
        vc1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)

        let vc2: UIViewController = UIViewController()
        vc2.tabBarItem = UITabBarItem(title: "My Wishlist", image: UIImage(systemName: "star.fill"), tag: 1)

        let vc3: UIViewController = UIViewController()
        vc3.tabBarItem = UITabBarItem(title: "My Cart", image: UIImage(systemName: "cart"), tag: 2)

        viewControllers = [vc1, vc2, vc3]
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let view = item.value(forKey: "view") as? UIView, let image = view.subviews.first as? UIImageView {

            //animating tab bar image
            let expandTransform = CGAffineTransform(scaleX: 0.84, y: 0.84);
            image.transform = expandTransform
            UIView.animate(withDuration: 0.7,
                           delay:0.0,
                           usingSpringWithDamping:0.40,
                           initialSpringVelocity:0.1,
                           options: .curveEaseOut,
                           animations: {
                            image.transform = expandTransform.inverted()
            }, completion: nil)
        }
    }
}
