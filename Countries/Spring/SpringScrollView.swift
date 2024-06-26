//
//  SpringScrollView.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 2.04.2024.
//

import UIKit

open class SpringScrollView: UIScrollView, Springable {
    @IBInspectable public var autostart: Bool = false
    @IBInspectable public var autohide: Bool = false
    @IBInspectable public var animation: String = ""
    @IBInspectable public var force: CGFloat = 1
    @IBInspectable public var delay: CGFloat = 0
    @IBInspectable public var duration: CGFloat = 0.7
    @IBInspectable public var damping: CGFloat = 0.7
    @IBInspectable public var velocity: CGFloat = 0.7
    @IBInspectable public var repeatCount: Float = 1
    @IBInspectable public var x: CGFloat = 0
    @IBInspectable public var y: CGFloat = 0
    @IBInspectable public var scaleX: CGFloat = 1
    @IBInspectable public var scaleY: CGFloat = 1
    @IBInspectable public var rotate: CGFloat = 0
    @IBInspectable public var curve: String = ""
    public var opacity: CGFloat = 1
    public var animateFrom: Bool = false

    lazy private var spring : Spring = Spring(self)

    override open func awakeFromNib() {
        super.awakeFromNib()
        self.spring.customAwakeFromNib()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        spring.customLayoutSubviews()
    }

    public func animate() {
        self.spring.animate()
    }

    public func animateNext(completion: @escaping () -> ()) {
        self.spring.animateNext(completion: completion)
    }

    public func animateTo() {
        self.spring.animateTo()
    }

    public func animateToNext(completion: @escaping () -> ()) {
        self.spring.animateToNext(completion: completion)
    }

}
