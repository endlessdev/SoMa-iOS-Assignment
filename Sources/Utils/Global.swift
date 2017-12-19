//
//  Global.swift
//  My Friends
//
//  Created by Jade Yeom on 2017. 10. 29..
//  Copyright © 2017년 Narin. All rights reserved.
//

import Foundation


let didUpdateFriendsNotification: Notification.Name = Notification.Name.init("did update todo list")

var friends: [Friend] = {
    
    do {
        let data: Data = try Data(contentsOf: Friend.dataURL())
        let decoder: PropertyListDecoder = PropertyListDecoder()
        let friends: [Friend]?
        
        friends = try? decoder.decode([Friend].self, from: data)
        return friends ?? []
    } catch {
        print(error.localizedDescription)
    }
    
    return []
}()

// Global Function
func saveCurrentFriends() {
    let encoder = PropertyListEncoder()
    
    do {
        let data = try encoder.encode(friends)
        try data.write(to: Friend.dataURL())
    } catch {
        print(error.localizedDescription)
    }
}

func getIndexByCell (cell:String!) -> Int{
    var retIndex: Int = -1
    for (index, elem) in friends.enumerated() {
        if (elem.cell == cell) {
            retIndex = index
            break
        }
    }
    return retIndex
}

