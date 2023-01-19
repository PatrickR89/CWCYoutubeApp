//
//  Constants.swift
//  YoutubeApp
//
//  Created by Patrick on 18.01.2023..
//

import Foundation



struct Constants {
    static let API_KEY = ""
    static let PLAYLIST_ID = ""
    static let API_URL = "https:youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(Constants.PLAYLIST_ID)&key=\(Constants.API_KEY)"
}
