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
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Text(profile.name ?? "")
        }
        
    }
}


