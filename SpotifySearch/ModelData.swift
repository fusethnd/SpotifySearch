//
//  ModelData.swift
//  SpotifySearch
//
//  Created by Thanadon Boontawee on 14/3/2567 BE.
//

import Foundation

class ModelData {
    static func searchSpotify(filePath: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let headers = [
            "X-RapidAPI-Key": "f34c28b1f7msh7a0baf86b094b37p13df52jsn498ecff72d7f",
            "X-RapidAPI-Host": "spotify23.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://spotify23.p.rapidapi.com/search/?q=%E0%B8%8A%E0%B8%AD%E0%B8%9A%E0%B8%99%E0%B8%AD%E0%B8%99&type=multi&offset=0&limit=10&numberOfTopResults=5")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data, let jsonString = String(data: data, encoding: .utf8) {
                print("Received JSON string:\n\(jsonString)")
            }
            
            if let data = data {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    print(jsonObject)
                } catch {
                    print("Error deserializing JSON: \(error)")
                }
            }

        }
        dataTask.resume()

    }
}
