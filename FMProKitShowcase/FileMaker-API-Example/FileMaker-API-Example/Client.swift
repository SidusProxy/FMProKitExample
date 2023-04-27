//
//  Client.swift
//  Example
//
//  Created by Gianluca Annina on 06/04/23.
//

import Foundation

struct Client: Codable, Hashable {
    let clientID: Int?
    let firstName, lastName: String?

        enum CodingKeys: String, CodingKey {
            case clientID = "ClientId"
            case firstName = "FirstName"
            case lastName = "LastName"
        }
}
