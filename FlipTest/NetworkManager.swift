//
//  Network.swift
//  FlipTest
//
//  Created by S. M. Faisal Rahman on 12/12/18.
//  Copyright © 2018 asd. All rights reserved.
//

import Foundation
import FGRoute

typealias GetCardCB = (Bool, String?, [String], Int) -> Void

class CardsResObj: Codable {
    var cards: [Int]?
    var msg: String?
    var gameId: Int?
}

class NetworkManager {
    static var sharedInstance: NetworkManager = NetworkManager()

    public var serverUrlString: String?

    private init() {}

    func getCards(for gameId: Int, withcallback callback: @escaping GetCardCB) {
        guard let serverUrlString = FGRoute.getGatewayIP() else {
            print("Network not connected")
            return
        }
        if let url = URL(string: "http://\(serverUrlString):3000\(Constants.serverPaths.dealCards)/\(gameId)") {
            let task = URLSession.shared.dataTask(with: url) { (data, res, error) in
                guard let dataRes = data, error == nil else {
                    callback(false, "Somethign went worng. Please check server address and connection", [], 0)
                    print(error ?? "")
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let getCardRes = try decoder.decode(CardsResObj.self, from: dataRes)
                    let cards = getCardRes.cards?.map { Constants.cardNames[$0] }
                    let newGameId = getCardRes.gameId ?? 0
                    callback(cards != nil, getCardRes.msg, cards ?? [], newGameId)
                } catch let parsingError {
                    callback(false, "JSON parsing error", [], 0)
                    print(parsingError)
                }
            }
            task.resume()
        } else {
            callback(false, "Bad URL", [], 0)
        }
    }
}
