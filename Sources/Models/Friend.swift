//
//  Friend.swift
//  My Friends
//
//  Created by Jade Yeom on 2017. 10. 28..
//  Copyright © 2017년 Narin. All rights reserved.
//

import Foundation

struct Friend : Codable{
    let name: Name!
    let email: String!
    let cell: String!
    let picture: Picture!
    let nat: Nationality!
    
    enum Nationality : String, Codable {
        /** DOCUMENT https://randomuser.me/documentation#nationalities **/
        case AU, BR, CA, CH, DE, DK, ES, FI, FR, GB, IE, IR, NL, NZ, TR, US
    }
    
    static func dataURL() throws -> URL {
        let fileManager = FileManager.default
        let documentURL: URL
        let friendURL: URL
        
        documentURL = try fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory,
                                          in: FileManager.SearchPathDomainMask.userDomainMask,
                                          appropriateFor: nil, create: false)
        friendURL = documentURL.appendingPathComponent("friends.plist")
        return friendURL
    }

}
