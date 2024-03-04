//
//  ProfilePicture.swift
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 04/03/24.
//

import SwiftUI

struct ProfilePicture: View {
    let imageURL: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL)){ image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
        } placeholder: {
            Color.gray
        }
    }
}

#Preview {
    ProfilePicture(imageURL: "https://static.tvmaze.com/uploads/images/original_untouched/432/1081522.jpg")
}
