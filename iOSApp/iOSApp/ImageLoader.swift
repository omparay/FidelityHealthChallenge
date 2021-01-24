//
//  ImageLoader.swift
//  iOSApp
//
//  Created by Oliver Paray on 1/24/21.
//

import AppFramework
import SwiftUI

struct ImageLoader: View {
    
    private class Loader: ObservableObject {
        var image = UIImage()
        
        init() {
            self.image = UIImage(systemName: "photo.fill")!
        }
        
        init(urlString: String?) {
            guard let urlSpec = urlString else {
                self.image = UIImage(systemName: "exclamationmark.icloud.fill")!
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
                return
            }
            let service = Service()
            service.getImage(urlString: urlSpec) { (result) in
                switch result {
                case .success(let image):
                    self.image = image
                case .failure(let error):
                    debugPrint("Error Loading image...",error)
                    self.image = UIImage(systemName: "exclamationmark.icloud.fill")!
                }
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }
        }
    }
    
    @StateObject private var loader: Loader
    
    init() {
        _loader = StateObject(wrappedValue: Loader())
    }
    
    init(urlString: String?) {
        _loader = StateObject(wrappedValue: Loader(urlString: urlString))
    }
    
    var body: some View {
        displayImage().resizable()
    }
    
    private func displayImage() -> Image {
        return Image(uiImage: loader.image)
    }
}

struct ImageLoader_Previews: PreviewProvider {
    static var previews: some View {
        ImageLoader()
    }
}
