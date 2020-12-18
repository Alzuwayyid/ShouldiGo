//
//  CircleView.swift
//  ShouldiGo
//
//  Created by Mohammed on 18/12/2020.
//

import UIKit

class CircleView: UIView {

    override class var layerClass: AnyClass { return CAShapeLayer.self }

    override func layoutSubviews() {
        super.layoutSubviews()

        let layer = self.layer as! CAShapeLayer
        layer.strokeColor = UIColor.blue.cgColor
        layer.fillColor = nil
        let width: CGFloat = 2
        layer.lineWidth = width
        layer.path = CGPath(ellipseIn: bounds.insetBy(dx: width / 2, dy: width / 2), transform: nil)
    }
}
