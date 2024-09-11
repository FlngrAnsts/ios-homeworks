//
//  Post.swift
//  Navigation
//
//  Created by Anastasiya on 28.03.2024.
//

import UIKit


public struct Post {
    
    public var author: String
    public var postDescription: String
    public var image: String
    public var likes: Int
    public var views: Int
    
   public init(author: String, postDescription: String, image: String, likes: Int, views: Int) {
        self.author = author
        self.postDescription = postDescription
        self.image = image
        self.likes = likes
        self.views = views
    }
    
}

extension Post {
    
    public static func make() -> [Post] {
        [
            Post(
                author: "STAR WARS",
                postDescription: "501-й легион, также известный как «Кулак Вейдера» во времена Галактической гражданской войны — легион элитных солдат-клонов, позже штурмовиков, во время Войн клонов выполнявший задания Верховного канцлера Палпатина, позже ставшего Галактическим Императором.",
                image: "appo",
                likes: 1002,
                views: 1580
            ),
            Post(
                author: "PhotoZone",
                postDescription: "Фотогра́фия — технология записи изображения путём регистрации оптических излучений с помощью светочувствительного фотоматериала или полупроводникового преобразователя.",
                image: "photograf",
                likes: 110,
                views: 135
            ),
            Post(
                author: "Inferno",
                postDescription: "Ваши ангелы вам врут, наши демоны нас берегут",
                image: "demon",
                likes: 839,
                views: 95
            ),
            Post(
                author: "Lykan",
                postDescription: "О́боротень — мифическое существо, способное временно менять свой облик магическим путём, превращаясь («оборачиваясь, перекидываясь») из человека в другое существо,и наоборот",
                image: "wolf",
                likes: 1000,
                views: 1500
            )
        ]
        
    }
}



