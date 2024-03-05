//
//  CastDetail.swift
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 04/03/24.
//

import SwiftUI

struct CastDetail: View {
    let cast: Cast
    
    var body: some View {
        VStack {
            ProfilePicture(imageURL: cast.person.image?.original ?? "")
                .frame(width: 100, height: 100)
            
            Text(cast.person.name ?? "")
            Text(cast.character?.name ?? "")
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    CastDetail(cast: JSONReader.load("CastDetailsMock"))
}
