//
//  SongSheetView.swift
//  Music Blender
//
//  Created by Tran Long on 09/03/2023.
//

import SwiftUI
import MusicKit


struct SongSheetView: View {
    
    @State var song:Song
    @State private var isPlaying = true
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            
            
            
            Spacer()
            
            VStack(alignment: .leading) {
                    
                    AsyncImage(url: song.artwork?.url(width: 350, height: 350))
                        .frame(width: 350, height: 350, alignment: .center)
                        .cornerRadius(10)
                    
                    Text(song.title)
                        .font(.largeTitle)
                        .bold()
                        
                    Text(song.artistName)
                        .font(.subheadline)

                }
            
            
            Spacer()
            
            Button {
                    if isPlaying {
                        ApplicationMusicPlayer.shared.pause()
                    } else {
                        Task{
                            do{
                                try await ApplicationMusicPlayer.shared.play()
                            }catch {
                                
                            }
                        }
                    }
                
                isPlaying.toggle()
            } label: {
                HStack {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .foregroundColor(.white)
                    
                    Text(isPlaying ? "Pause" : "Play")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 15)
                .background(Color.purple)
                .cornerRadius(10)
            }
            
            Spacer()

        }
    }
}

