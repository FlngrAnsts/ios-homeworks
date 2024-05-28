//
//  Photo.swift
//  Navigation
//
//  Created by Anastasiya on 28.05.2024.
//

import UIKit


public struct Photo {
    
    public var id: Int
    public var image: String
   
}

extension Photo {
    
    public static func make() -> [Photo] {
        
        (1...20).map{Photo(id: $0, image: "Image_\($0)")}
        
    }
    
}
