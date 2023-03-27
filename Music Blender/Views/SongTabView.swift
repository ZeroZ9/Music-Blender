//
//  SongTabView.swift
//  Music Blender
//
//  Created by Tran Long on 09/03/2023.
//

import SwiftUI

struct SongTabView: View {
    
    var song:Item
    
    var body: some View {
        AsyncImage(url: song.imageUrl)
            .frame(width: 75, height: 75, alignment: .center)
        VStack(alignment: .leading) {
            Text(song.name)
                .font(.headline)
                .bold()
            Text(song.artist)
        }.padding()
    }
}


