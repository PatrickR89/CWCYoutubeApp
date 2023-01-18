//
//  Video.swift
//  YoutubeApp
//
//  Created by Patrick on 12.01.2023..
//

import Foundation

struct Video: Decodable {
    var video: String
    var title: String
    var description: String
    var thumbnail: String
    var published: Date

    enum CodingKeys: String, CodingKey {
        case snippet
        case thumbnails
        case high
        case resourceId

        case published = "publishedAt"
        case title = "title"
        case description = "description"
        case thumbnail = "url"
        case video = "videoId"
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)

        self.title = try snippetContainer.decode(String.self, forKey: .title)
        self.description = try snippetContainer.decode(String.self, forKey: .description)
        self.published = try snippetContainer.decode(Date.self, forKey: .published)

        let thumbnailContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        let highContainer = try thumbnailContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        self.thumbnail = try highContainer.decode(String.self, forKey: .thumbnail)

        let resourceContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
        self.video = try resourceContainer.decode(String.self, forKey: .video)
    }
}
