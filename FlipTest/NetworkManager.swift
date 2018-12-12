//
//  Network.swift
//  FlipTest
//
//  Created by S. M. Faisal Rahman on 12/12/18.
//  Copyright © 2018 asd. All rights reserved.
//

import Foundation

class NetworkManager {
    static var sharedInstance: NetworkManager = NetworkManager()

    private init() {}

    func getCards() -> [String] {
        return []
    }
}
