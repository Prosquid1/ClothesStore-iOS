//
//  AnimatedTabBarController.swift

//  Added by Oyeleke Okiki on 7/12/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class AnimatedTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1: UIViewController = HomeController()
        vc1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)

        let vc2: UIViewController = WishListController()
        vc2.tabBarItem = UITabBarItem(title: "My Wishlist", image: UIImage(systemName: "star.fill"), tag: 1)

        let vc3: UIViewController = CartController()
        vc3.tabBarItem = UITabBarItem(title: "My Cart", image: UIImage(systemName: "cart"), tag: 2)

        viewControllers = [vc1, vc2, vc3]
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }

        let timeInterval: TimeInterval = 0.3
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
            barItemView.transform = CGAffineTransform.identity.scaledBy(x: 0.7, y: 0.7)
        }
        propertyAnimator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
        propertyAnimator.startAnimation()
    }
}
