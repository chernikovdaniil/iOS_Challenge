//
//  RepositoryOwner.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import Foundation

class RepositoryOwner: Decodable {
    let login: String?
    let avatarURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.login = try container?.decode(String.self, forKey: .login)
        
        if let avatarStr = try container?.decode(String.self, forKey: .avatarURL) {
            self.avatarURL = URL(string: avatarStr)
        } else {
            self.avatarURL = .none
        }
    }
}
