//
//  TVShowHorizontalView.swift
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 04/03/24.
//

import SwiftUI

struct TVShowHorizontalView: View {
    var showDetails: ShowDetailsModel
    
    var body: some View {
        HStack() {
            AsyncImage(url: URL(string: showDetails.image?.original ?? "")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
                    .background(Color.gray.opacity(0.1))
                    .aspectRatio(3/4, contentMode: .fit)
            }
            .aspectRatio(3/4, contentMode: .fit)
            
            VStack(alignment: .leading) {
                Text(showDetails.name ?? "")
                    .font(.system(size: 14))
                    .lineLimit(2)
                    .fontWeight(.bold)
                    .fixedSize(horizontal: false, vertical: false)
                    .minimumScaleFactor(0.5)
                .layoutPriority(1)
                
                Text(showDetails.premiered?.prefix(4) ?? "")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: true, vertical: false)
                    .minimumScaleFactor(0.5)
                    .layoutPriority(1)
            }
        }
    }
}

#Preview {
    TVShowHorizontalView(showDetails: JSONReader.load("ShowDetailsMock"))
}
