//
//  SearchViewModel.swift
//  iOSApp
//
//  Created by Oliver Paray on 1/23/21.
//

import AppFramework
import Foundation

class SearchViewModel: ObservableObject {
    
    //MARK: Properties
    @Published var searchResults: SearchResults {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var searchText: String {
        didSet {
            performSearch(searchText: searchText)
        }
    }
    
    //MARK: Initializers
    init() {
        self.searchText = String()
        self.searchResults = SearchResults.empty
    }
    
    //MARK: Class Methods
    private func performSearch(searchText: String) {
        let service = Service()
        service.search(text: searchText) { (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    debugPrint("Success!!!")
                    self.searchResults = results
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    debugPrint("Error!!!",error)
                }
            }
        }
    }
    
    //MARK: Public Methods
    
    
    //MARK: Delegates
    
    
    //MARK: Datasource
    
    
    //MARK: Handlers

}
