//
//  Profile.swift
//  Music Blender
//
//  Created by Saahi Arumilli on 3/25/23.
//

import Foundation
import MusicKit

struct Profile: Identifiable, Hashable {
    var idNum: String //This is the documents field on Firebase - Name of user
    var name: String //The name of the user a field within each document
    var location: String
    var userName: String
    var password: String
    var genres: Array<String>
    var artists: Array<String>
    var birthday: String // In the format "02/02/2002"
    
    
}

