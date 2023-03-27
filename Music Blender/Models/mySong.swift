//
//  File.swift
//  Music Blender
//
//  Created by Tran Long on 09/02/2023.
//

import Foundation

struct mySong: Identifiable, Decodable{
    
    var id: String
    var artist: String
    var songTitle: String
}
