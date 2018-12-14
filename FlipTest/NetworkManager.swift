//
//  Network.swift
//  FlipTest
//
//  Created by S. M. Faisal Rahman on 12/12/18.
//  Copyright © 2018 asd. All rights reserved.
//

import Foundation

typealias GetCardCB = ([String]) -> Void

class NetworkManager {
    static var sharedInstance: NetworkManager = NetworkManager()

    private init() {}

    func getCards(withcallback callback: @escaping GetCardCB) {
        var cards: [String] = [String]()
        callback(cards)
    }
}
