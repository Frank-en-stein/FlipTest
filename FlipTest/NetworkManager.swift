//
//  Network.swift
//  FlipTest
//
//  Created by S. M. Faisal Rahman on 12/12/18.
//  Copyright © 2018 asd. All rights reserved.
//

import Foundation
import FGRoute

typealias GetCardCB = (Bool, String?, [String]) -> Void

class CardsResObj: Codable {
    var cards: [Int]?
    var msg: String?
    var gameId: Int?
}

class NetworkManager {
    static var sharedInstance: NetworkManager = NetworkManager()

    public var serverUrlString: String?

    private init() {}

    func getCards(for gameId: Int = 0, withcallback callback: @escaping GetCardCB) {
        guard let serverUrlString = FGRoute.getGatewayIP() else {
            print("Network not connected")
            getCards(withcallback: callback)
            return
        }
        if let url = URL(string: "http://\(serverUrlString):3000\(Constants.serverPaths.dealCards)/\(gameId)") {
            let task = URLSession.shared.dataTask(with: url) { [gameId] (data, res, error) in
                guard let dataRes = data, error == nil else {
                    callback(false, "Somethign went worng. Please check server address and connection", [])
                    print(error ?? "")
                    self.getCards(withcallback: callback)
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let getCardRes = try decoder.decode(CardsResObj.self, from: dataRes)
                    let cards = getCardRes.cards?.map { Constants.cardNames[$0] }
                    let newGameId = getCardRes.gameId ?? gameId
                    callback(cards != nil, getCardRes.msg, cards ?? [])
                    self.getCards(for: newGameId, withcallback: callback)
                } catch let parsingError {
                    callback(false, "JSON parsing error", [])
                    print(parsingError)
                    self.getCards(withcallback: callback)
                }
            }
            task.resume()
        } else {
            callback(false, "Bad URL", [])
            self.getCards(withcallback: callback)
        }
    }
}
