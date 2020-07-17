//
//  WildCardGestureRecognizer.swift
//  WeatherDemo
//
//  Created by Davi Chaves on 7/17/20.
//  Copyright © 2020 Davi Chaves. All rights reserved.
//

import Foundation

import UIKit.UIGestureRecognizerSubclass

class WildCardGestureRecognizer: UITapGestureRecognizer {

    var touchesBeganCallback: ((Set<UITouch>, UIEvent) -> Void)?
    
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
        self.cancelsTouchesInView = false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        touchesBeganCallback?(touches, event)
    }

    override func canPrevent(_ preventedGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }

    override func canBePrevented(by preventingGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}
