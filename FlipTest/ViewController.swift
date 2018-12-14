//
//  ViewController.swift
//  FlipTest
//
//  Created by S. M. Faisal Rahman on 12/12/18.
//  Copyright © 2018 asd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var cards: [CardView]!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        cards.forEach {
            $0.frame = CGRect(x: $0.frame.origin.x, y: $0.frame.origin.y, width: $0.frame.width, height: $0.frame.width * Constants.cardAspectRatio)
            $0.canFlip = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func requestCardDidTap(_ sender: UIButton) {
        NetworkManager.sharedInstance.getCards() { [weak self] cardNames in
            cardNames.enumerated().forEach { arg in
                let (index, card) = arg
                self?.cards[index].setCard(withCardType: card)
            }
        }
    }
}

