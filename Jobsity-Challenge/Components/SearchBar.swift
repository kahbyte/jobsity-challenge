//
//  SearchBar.swift
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 04/03/24.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    var onCommit: () -> Void

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String
        var onCommit: () -> Void

        init(text: Binding<String>, onCommit: @escaping () -> Void) {
            _text = text
            self.onCommit = onCommit
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            onCommit()
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text, onCommit: onCommit)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}
