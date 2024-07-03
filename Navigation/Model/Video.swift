//
//  Video.swift
//  Navigation
//
//  Created by Anastasiya on 03.07.2024.
//

import Foundation
struct Video {
    let url: String
    let label: String
}


extension Video {
    static func make() -> [Video] {
        return [
            Video(url: "Lost [Official Music Video] - Linkin Park", label: "Linkin Park『Lost』"),
            Video(url: "Imagine Dragons", label: "Imagine Dragons & JID 『Enemy』"),
            Video(url: "The Clone Wars - Warriors", label: "The Clone Wars 『Warriors』"),
            Video(url: "the GazettE 『THE SUICIDE CIRCUS』Music Video", label: "the GazettE 『Suicide Circus』"),
                        
        ]
    }
}
