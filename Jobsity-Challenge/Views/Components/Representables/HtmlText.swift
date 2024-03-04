//
//  HtmlText.swift
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 04/03/24.
//

import SwiftUI

import WebKit
import SwiftUI

struct HTMLText: View {
    let html: String
    let fontSize: CGFloat
    
    var body: some View {
        if let nsAttributedString = try? NSAttributedString(data: Data(html.utf8), options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil),
           let attributedString = try? AttributedString(nsAttributedString, including: \.uiKit) {
            Text(attributedString)
                .font(.system(size: fontSize))
        } else {
            Text(html)
                .font(.system(size: fontSize))
        }
    }
}

#Preview {
    HTMLText(html: "<p><b>Ted Lasso </b>centers on an idealistic — and clueless — all-American football coach hired to manage an English football club — despite having no soccer coaching experience at all.</p>", fontSize: 12)
}
