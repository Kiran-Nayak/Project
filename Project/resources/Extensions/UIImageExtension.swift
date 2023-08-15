//
//  UIImageExtension.swift
//  Project
//
//  Created by Kiran Nayak on 15/08/23.
//

import Foundation
import UIKit

protocol Blurable {
    func addBlur(_ alpha: CGFloat)
}

extension Blurable where Self: UIView {
    func addBlur(_ alpha: CGFloat = 0.5) {
        let effect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: effect)
        
        effectView.frame = self.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = alpha
        
        self.addSubview(effectView)
    }
}

extension UIView: Blurable {}
