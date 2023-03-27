//
//  ContentView.swift
//  Music Blender
//
//  Created by Tran Long on 01/02/2023.
//

import SwiftUI
import MusicKit

struct ContentView: View {
    
    @ObservedObject var model = ViewModel()
    
    // HARD CODE EXPE
    @State private var myCity:String? = "Miami"

    // MARK: Searching city var for search function
    @State private var searchingCity = ""
    @State private var isPlaying = false
    @State private var plyaingSong:Song?
    
    // MARK: isSheet for songplay
    @State private var showingSheet = false
    
    var body: some View {
        
        NavigationView{
            VStack {
                
                // MARK: Searching bar
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search City...", text: $searchingCity)
                    
                    Button {
                        searchingCity = ""
                        getCurrentplace()
                    } label: {
                        Image(systemName: "location.circle")
                    }

                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onSubmit {
                    // When user press return
                    self.model.getData(city: searchingCity )
                    self.myCity = searchingCity
                }
                
                // MARK: List of a Song
                List(model.songs) { song in
                    HStack {
                        
                        SongTabView(song: song)
                        
                        Spacer()
                        
                        // MARK: Play button song
                        Button(action: {
   
                            let mySong: Song = song.song
                            plyaingSong = mySong
                            
                            ApplicationMusicPlayer.shared.queue = [mySong]
                            Task {
                                do {
                                    self.isPlaying = true // Show loading indicator/message
                                    try await ApplicationMusicPlayer.shared.play()
                                } catch {
                                    // Handle the error here
                                }
                                self.isPlaying = false // Hide loading indicator/message
                            }
                            
                            showingSheet.toggle()
                            
                        }) {
                                // Show styled button text
                            Text("Play")
                                .font(.system(.subheadline,design: .rounded))
                                .bold()
                                .foregroundStyle(LinearGradient(colors: [.red,.orange,.yellow], startPoint: .topLeading, endPoint: .bottomTrailing))
                            
                        }.sheet(isPresented: $showingSheet) {
                            SongSheetView(song: plyaingSong ?? model.songs[0].song )
    
                        }
                        
                    }
                }
            
            }
            .toolbar{
                // MARK: City Name at Navigation
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    Text(model.cityName ?? "")
                        .font(.system(.largeTitle,design: .rounded))
                        .bold()
                        .foregroundStyle(LinearGradient(colors: [.red,.orange,.yellow], startPoint: .topLeading, endPoint: .bottomTrailing))
                }
                
                // MARK: Profile user at Navigation
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "person.crop.circle.fill")
                }
            }
        }
        
    }
    
    init() {
        getCurrentplace()
    }
    
    private func getCurrentplace() {
        let mlem = MyLocationManager()
        mlem.getCurrentCity {[self] city in
            if let city {
               print("User is at \(city)")
                self.model.getData(city: city )
                self.myCity = city
            }else {
                print("ERROR")
            }
        }
    }
    


}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
