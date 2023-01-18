//
//  APICaller.swift
//  YoutubeApp
//
//  Created by Patrick on 12.01.2023..
//

import Foundation

class APICaller {

    func getVideos() {
        let url = URL(string: Constants.API_URL)

        guard let url = url else {
            return
        }

        let session = URLSession.shared

        let dataTask = session.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {return}
            print(response)
        }

        dataTask.resume()
    }
}
