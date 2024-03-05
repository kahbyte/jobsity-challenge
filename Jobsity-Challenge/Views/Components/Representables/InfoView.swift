//
//  InfoView.swift
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 04/03/24.
//

import SwiftUI

struct InfoView: View {
    var title: String
    var info: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
            Text(info)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    InfoView(title: "Released", info: "2024")
}
