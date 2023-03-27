//
//  ViewModel.swift
//  Music Blender
//
//  Created by Tran Long on 09/02/2023.
//

import Foundation
import Firebase
import MusicKit

class ViewModel: ObservableObject {
    var list = [mySong]()
    var user = [Profile]()
    @Published var songs = [Item]()
    @Published var songsApple = [Song]()
    var cityName:String?
    
    // MARK: Fetching the data from FireBase
    
    func getData( city: String) {
        
        // MARK: When getdata from new City, songs list should be empty to renew
        songs.removeAll()
        
        self.cityName = city
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // red the docs at the specific path
        db.collection(city).getDocuments { snapshot, error in
            // Check for the error
            
            if error == nil {
                // No erroros
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        
                        // Get all the doc and creaete Songs
                        self.list = snapshot.documents.map { d in
                            return mySong(id: d.documentID, artist: d["artist"] as? String ?? "hi", songTitle: d["songTitle"] as? String ?? "mlem")
                        }
                        
                        
                        //Fetch music
                        self.fetchMusic(listne: self.list)
                    }
                    
                }
                
            } else {
                // Handle the error
            }
        }
        
    }
    
    func getUserData() {
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Read the documents at the specific path
        db.collection("User Profiles").getDocuments { snapshot, error in
            // Check for errors
            if let error = error {
                print("Error getting user profiles: \(error.localizedDescription)")
                return
            }
            
            // No errors, handle the snapshot
            guard let snapshot = snapshot else {
                print("No user profiles found")
                return
            }
            
            DispatchQueue.main.async {
                // Map the documents to Profile objects
                self.user = snapshot.documents.map { document in
                    let data = document.data()
                    let idNum = document.documentID
                    let name = data["name"] as? String ?? ""
                    let location = data["userLocation"] as? String ?? ""
                    let userName = data["userName"] as? String ?? ""
                    let password = data["password"] as? String ?? ""
                    let genres = data["Genres"] as? [String] ?? []
                    let artists = data["artists"] as? [String] ?? []
                    let birthday = data["birthday"] as? String ?? ""
                    
                    return Profile(idNum: idNum, name: name, location: location, userName: userName, password: password, genres: genres, artists: artists, birthday: birthday)
                }
            }
        }
    }

        
    
    // MARK: Fetching the data from Apple MusicKit
    
    func fetchMusic(listne: [mySong]){
            
        Task {
            // Request permisson
            let status = await MusicAuthorization.request()
            switch status {
            case .authorized:
                //
                for n in listne{
                    let request: MusicCatalogSearchRequest = {
                        var request = MusicCatalogSearchRequest(term: n.songTitle, types: [Song.self])
                        
                        request.limit = 1
                        return request
                    }()
                    do {
                        let result = try await request.response()
                        
                        DispatchQueue.main.async {
                            self.songs += result.songs.compactMap({
                                return .init(song: $0,id: $0.id, name: $0.title, artist: $0.artistName, imageUrl: $0.artwork?.url(width: 75, height: 75),playParameters: $0.playParameters,url: $0.url)
                            })
                            
                            self.songsApple += result.songs
                        }
                        
                    } catch {
                        print("hihii")
                    }
                    //
                }
                
            default:
                break
            }
        }
        
    }

    
    

    
}
