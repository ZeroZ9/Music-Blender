//
//  Item.swift
//  Music Blender
//
//  Created by Tran Long on 09/02/2023.
//

import Foundation
import MusicKit

struct Item: Identifiable, Hashable {
    var song: Song
    var id: MusicItemID
    let name: String
    let artist: String
    let imageUrl: URL?
    let playParameters: PlayParameters?
    let url: URL?
}
