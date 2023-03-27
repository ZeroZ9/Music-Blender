//
//  UserView.swift
//  Music Blender
//
//  Created by Long Tran M2 on 27/3/23.
//

import SwiftUI

struct UserView: View {
    
    @State var profile:Profile

    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                
                Spacer()
                
                HStack{
                    Image(systemName: "person.crop.square.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                    VStack(alignment:.leading){
                        Text(profile.name ?? "")
                            .font(.title)
                        Text(profile.birthday ?? "")
                        Text(profile.userName ?? "")
                        Text(profile.location ?? "")
                    }.padding(.leading)
                }
                
                Divider()
                
                Spacer()
                
                VStack(alignment: .leading){
                    
                    Text("Gernes")
                        .font(.title2)
                        .bold()
                    
                    HStack {
                        ForEach(profile.genres ?? [], id: \.self) { gerne in
                            Text(gerne)
                        }
                    }
                    
                    Text("Artists")
                        .font(.title2)
                        .bold()
                    
                    HStack {
                        ForEach(profile.artists ?? [], id: \.self) { artist in
                            Text(artist)
                        }
                    }
                }
                
                Spacer()
                
            }.padding()
                .navigationTitle("Welcome")
        }
    }
}


