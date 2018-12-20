//
//  Network.swift
//  FlipTest
//
//  Created by S. M. Faisal Rahman on 12/12/18.
//  Copyright © 2018 asd. All rights reserved.
//

import Foundation

typealias GetCardCB = (Bool, String?, [String]) -> Void

class CardsResObj: Codable {
    var cards: [Int]?
    var msg: String?
}

class NetworkManager {
    static var sharedInstance: NetworkManager = NetworkManager()

    public static var serverUrlString: String = "192.168.0.2"

    private init() {}

    func getCards(withcallback callback: @escaping GetCardCB) {
        if let url = URL(string: "http://\(NetworkManager.serverUrlString)\(Constants.serverPaths.dealCards)") {
            let task = URLSession.shared.dataTask(with: url) { (data, res, error) in
                guard let dataRes = data, error == nil else {
                    callback(false, "Somethign went worng. Please check server address and connection", [])
                    print(error ?? "")
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let getCardRes = try decoder.decode(CardsResObj.self, from: dataRes)
                    let cards = getCardRes.cards?.map { Constants.cardNames[$0] }
                    callback(true, getCardRes.msg, cards ?? [])
                } catch let parsingError {
                    callback(false, "JSON parsing error", [])
                    print(parsingError)
                }
            }
            task.resume()
        } else {
            callback(false, "Bad URL", [])
        }
    }
}
