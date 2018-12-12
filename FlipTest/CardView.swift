//
//  ViewController.swift
//  FlipTest
//
//  Created by S. M. Faisal Rahman on 12/12/18.
//  Copyright © 2018 asd. All rights reserved.
//

import UIKit

@IBDesignable
class CardView: UIView {
    private var backImageView: UIImageView!
    private var frontImageView: UIImageView!

    private var showingBack = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }

    private func configureView() {
        frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width * 230/171.5)
        bounds = CGRect(x: 0, y: 0, width: frame.width, height: frame.width * 230/171.5)

        frontImageView = UIImageView(image: Utility.scaleUIImageToSize(image: UIImage(named: "backside") ?? UIImage(), size: frame.size))
        backImageView = UIImageView(image: Utility.scaleUIImageToSize(image: UIImage(named: "black_joker") ?? UIImage(), size: frame.size))

        frontImageView.contentMode = .scaleAspectFit
        backImageView.contentMode = .scaleAspectFit

        addSubview(frontImageView)
        frontImageView.translatesAutoresizingMaskIntoConstraints = false

        let singleTap = UITapGestureRecognizer(target: self, action: #selector(flip))
        singleTap.numberOfTapsRequired = 1
        addGestureRecognizer(singleTap)
    }

    @objc func flip() {
        let toView = showingBack ? frontImageView : backImageView
        let fromView = showingBack ? backImageView : frontImageView
        UIView.transition(from: fromView!, to: toView!, duration: 1, options: .transitionFlipFromRight, completion: nil)
        toView?.translatesAutoresizingMaskIntoConstraints = false
        showingBack = !showingBack
    }
}
