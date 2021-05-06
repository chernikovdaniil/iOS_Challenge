//
//  Repository.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import Foundation

class Repository: Decodable {
    let id: Int?
    let name: String?
    let owner: RepositoryOwner?
    
    let createdAt: Date?
    let updatedAt: Date?
    let pushedAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case owner
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
    }
    
    init(id: Int?, name: String?, owner: RepositoryOwner?,
         createdAt: Date?, updatedAt: Date?, pushedAt: Date?) {
        self.id = id
        self.name = name
        self.owner = owner
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.pushedAt = pushedAt
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? container.decode(Int.self, forKey: .id)
        self.name = try? container.decode(String.self, forKey: .name)
        self.owner = try? container.decode(RepositoryOwner.self, forKey: .owner)
        
        func decodeDateFromString(at key: CodingKeys,
                                  from container: KeyedDecodingContainer<Repository.CodingKeys>) -> Date? {
            guard let string = try? container.decode(String.self, forKey: key) else { return .none }
            let dateFormat = "E, d MMM yyyy HH:mm"
            return Date.dateFromString(string, format: dateFormat)
        }
        
        self.createdAt = decodeDateFromString(at: .createdAt, from: container)
        self.updatedAt = decodeDateFromString(at: .updatedAt, from: container)
        self.pushedAt = decodeDateFromString(at: .pushedAt, from: container)
    }
}

extension Repository {
    static let initial = Repository(id: nil, name: nil, owner: nil,
                                    createdAt: nil, updatedAt: nil, pushedAt: nil)
}

