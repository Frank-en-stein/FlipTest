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
    var canFlip = false
    private var backImageView: UIImageView!
    private var frontImageView: UIImageView!

    private var showingBack = false

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }

    func setCard(withCardType cardType: String) {
        backImageView = UIImageView(image: UIImage(named: cardType))
        canFlip = backImageView.image != nil
    }

    func configureView() {
        backImageView = UIImageView(image: nil)
        frontImageView = UIImageView(image: UIImage(named: Constants.cardType.backside.rawValue))

        frontImageView.frame = bounds
        backImageView.frame = bounds

        frontImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        addSubview(frontImageView)

        let singleTap = UITapGestureRecognizer(target: self, action: #selector(flip))
        singleTap.numberOfTapsRequired = 1
        addGestureRecognizer(singleTap)
    }

    @objc func flip() {
        if !canFlip {
            return
        }
        let toView = showingBack ? frontImageView : backImageView
        let fromView = showingBack ? backImageView : frontImageView
        UIView.transition(from: fromView!, to: toView!, duration: 1, options: .transitionFlipFromRight, completion: nil)
        showingBack = !showingBack

        frontImageView.frame = bounds
        backImageView.frame = bounds

        frontImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
