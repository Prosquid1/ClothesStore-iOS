//
//  CSFavButton.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/13/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import FaveButton

class CSFavButton: FaveButton {
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.normalColor = UIColor.red
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.normalColor = UIColor.red
    }
}
