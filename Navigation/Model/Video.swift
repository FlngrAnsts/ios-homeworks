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
    
    static func makeWeb() -> [Video] {
        return [
            
            Video(url: "https://www.youtube.com/embed/eX3ZyLNbV_Y?si=XDuCWznKfrZ_2XhY", label: "The Clone Wars 『Warriors』"),
            
            Video(url: "https://www.youtube.com/embed/eEFVxI9lqjU?si=n1ZuQB0XYFYfZAxD", label: "『Everything Goes On』"),
//
            Video(url: "https://www.youtube.com/embed/F5tSoaJ93ac?si=H4L5XfIempwxTQUY", label: "Imagine Dragons & JID 『Enemy』"),
//
            Video(url: "https://www.youtube.com/embed/0nlJuwO0GDs?si=Ne0BPQjtBfDmS9uQ", label: "『Get Jinxed』"),
//
        ]
    }
}
