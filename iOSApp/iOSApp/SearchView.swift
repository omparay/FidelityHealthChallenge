//
//  ContentView.swift
//  iOSApp
//
//  Created by Oliver Paray on 1/23/21.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        VStack(alignment: .center,
               spacing: nil,
               content: {
                SearchBar()
                SearchList()
                Spacer()
               })
    }
}

struct SearchBar: View {
    @State var searchText = String()
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
    var body: some View {
        List {
            SearchItem()
            SearchItem()
        }
    }
}

struct SearchItem: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
