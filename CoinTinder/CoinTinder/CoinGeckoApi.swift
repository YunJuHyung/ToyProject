//
//  CoinGeckoApi.swift
//  CoinTinder
//
//  Created by 윤주형 on 11/27/24.
//

import Foundation

class CoinGeckoApi {
    
    //
    func asd() async throws {

        let url = URL(string: "https://api.coingecko.com/api/v3/search/treding")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "x-cg-demo-api-key": "CG-NkCU3DtTBmih9BjCjmeexGNj"
        ]

        let (data, _) = try await URLSession.shared.data(for: request)
        print(String(decoding: data, as: UTF8.self))
        
    }
    
}
