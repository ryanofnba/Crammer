//
//  Ranking.swift
//  ParseStarterProject
//
//  Created by Ryan Huang on 5/23/16.
//  Copyright © 2016 Parse. All rights reserved.
//

class Ranking: NSObject {
    
    var rankId: Int
    var location: Float
    
    

    init(rankId: Int, location: Float) {
        self.rankId = rankId
        self.location = location
    }
    
    func getRankId() -> Int {
        return rankId
    }
    
}
