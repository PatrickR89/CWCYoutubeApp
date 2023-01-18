//
//  APICaller.swift
//  YoutubeApp
//
//  Created by Patrick on 12.01.2023..
//

import Foundation

class APICaller {

    weak var delegate: APICallerDelegate?

    func getVideos() {
        let url = URL(string: Constants.API_URL)

        guard let url = url else {
            return
        }

        let session = URLSession.shared

        let dataTask = session.dataTask(with: url) { [weak self] data, response, error in
            if error != nil || data == nil {return}

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601

                let response = try decoder.decode(Response.self, from: data!)
                guard let data = response.items else {return}
                self?.delegate?.apiCaller(didRecieve: data)
            } catch {
                print("error in api caller", error)
            }
        }

        dataTask.resume()
    }
}

protocol APICallerDelegate: AnyObject {
    func apiCaller(didRecieve reponse: [Video])
}
