//
//  UnsplashResult.swift
//  Wallcraft_Task
//
//  Created by DENIS SYTYTOV on 06.12.2021.
//

import Foundation

struct UnsplashResultData : Codable{
    var id : String
    var description : String?
    var user : User
    var urls : URLs
}

struct User : Codable{
    let name : String
}

struct URLs : Codable{
    let small : String
}
