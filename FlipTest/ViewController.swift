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
    @IBOutlet var changeDealerButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NetworkManager.sharedInstance.getCards() { [weak self] (isSuccess, msg, cardNames) in
            if isSuccess {
                cardNames.enumerated().forEach { arg in
                    let (index, card) = arg
                    DispatchQueue.main.async {
                        self?.cards[index].configureView()
                        self?.cards[index].setCard(withCardType: card)
                        self?.cards[index].flipBack()
                    }
                }
                self?.alert(message: "Fetched new cards")
            } else {
                if let alertMsg = msg {
                    print(alertMsg)
                }
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        cards.forEach {
            $0.frame = CGRect(x: $0.frame.origin.x, y: $0.frame.origin.y, width: $0.frame.width, height: $0.frame.width * Constants.cardAspectRatio)
            $0.canFlip = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //changeDealerButton.customView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeDealerDidTap)))
    }

//    @objc func changeDealerDidTap() {
//        let alert = UIAlertController(title: "Change Dealer", message: "Enter ip", preferredStyle: .alert)
//        alert.addTextField { (textField) in
//            textField.text = NetworkManager.serverUrlString
//        }
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
//            if let newIp = alert?.textFields?[0].text {
//                print("Text field: \(String(describing: newIp))")
//                NetworkManager.serverUrlString = newIp
//            }
//        }))
//        self.present(alert, animated: true, completion: nil)
//    }

    @IBAction func requestCardDidTap(_ sender: UIButton) {
        cards.forEach { $0.flip() }
    }
}

