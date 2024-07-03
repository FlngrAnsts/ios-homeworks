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
            Video(url: "https://www.youtube.com/embed/eqhF1vKGlb0?si=3Omvwp0v-R4m54L8", label: "the GazettE 『THE SUICIDE CIRCUS』Music Video"),
            Video(url: "https://www.youtube.com/embed/7NK_JOkuSVY?si=asNwmzfcmK-9y4Uc", label: "Linkin Park 『Lost』 [Official Music Video]"),
            Video(url: "https://youtu.be/F5tSoaJ93ac?si=v5HBXZubRaxIivd0", label: "Imagine Dragons & JID 『Enemy』"),
            Video(url: "https://youtu.be/eX3ZyLNbV_Y?si=z8wrFrXN7mlfWpzX", label: "The Clone Wars 『Warriors』"),
            
        ]
    }
}
