//
//  ContentView.swift
//  iOSApp
//
//  Created by Oliver Paray on 1/23/21.
//

import AppFramework
import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel = SearchViewModel()
    var body: some View {
        VStack(alignment: .center,
               spacing: nil,
               content: {
                SearchBar(searchText: $viewModel.searchText)
                SearchList(searchResults: $viewModel.searchResults)
                Spacer()
               })
    }
}

struct SearchBar: View {
    @Binding var searchText: String
    var body: some View {
        HStack(alignment: .center,
               spacing: nil,
               content: {
                Text("Search:").padding(10)
                HStack(alignment: .center,
                       spacing: nil,
                       content: {
                        TextField("Naruto", text: $searchText)
                            .font(Font.system(size: 18,
                                              weight: .regular,
                                              design: .default))
                       })
                    .padding(8)
                    .border(Color.black,
                            width: 3)
                    .cornerRadius(1.5)
                Spacer()
               })
    }
}

struct SearchList: View {
    @Binding var searchResults: SearchResults
    var body: some View {
        List {
            ForEach(searchResults.results, id: \.malId) { result in
                SearchItem(searchItem: result)
            }
        }
    }
}

struct SearchItem: View {
    @State var searchItem: SearchResult
    var body: some View {
        HStack(alignment: .top, spacing: 5, content: {
            ImageLoader(urlString: searchItem.imageUrl)
                .frame(width:(UIDevice.current.userInterfaceIdiom == .pad) ? 256 : 96,
                       height:(UIDevice.current.userInterfaceIdiom == .pad) ? 320 : 128)
            VStack(alignment: .leading, spacing: nil, content: {
                Text("Title: \(searchItem.title ?? "")")
                Text("")
                Text("Synopsis:")
                Text(searchItem.synopsis ?? "")
            })
        }).frame(height:(UIDevice.current.userInterfaceIdiom == .pad) ? 360 : 256)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchView()
            SearchView()
                .previewDevice("iPhone 11 Pro Max")
            SearchView()
                
        }
    }
}
